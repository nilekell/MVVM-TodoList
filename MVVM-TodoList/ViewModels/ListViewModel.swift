//
//  ListViewModel.swift
//  MVVM-TodoList
//
//  Created by Nile Kelly on 21/01/2024.
//

import Foundation

/*
 This view-model is a Struct. Structs are based on VALUES and not INSTANCES... When you "update" a Class, you can access the instance of the class and change values inside. However, as Structs don't have instances and are based directly on their values, you can't change a value in a struct, otherwise it would be a different struct. Instead, we can "mutate" the struct, which is really just creating a new Struct and replacing it with the current one. In the update function, we are creating a totally new Struct, however, we are initializing it with most of the values from the current/previous struct.
 */
class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        //        this is a computed property
        //        this function is called whenever items changes
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        //        'data' and 'savedItems' are optional (nullable) variables
        //        using guard allows this variable to be safely unwrapped
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    //    CRUD functions below
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem: ItemModel = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        //        find item in items array
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
        
        /*
         This code is the same as the above code:
         if let index = items.firstIndex { (existingItem) -> Bool in
         return existingItem.id == item.id
         ) {
         items[index] = item.updateCompletion()
         }}
         */
    }
    
    func saveItems() {
        //        if let statement with 'try' is trying to assign a variable and if there are any errors, they can be caught
        if let encodedData = try? JSONEncoder().encode(items) {
            //            UserDefaults is key-value storage
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
