//
//  ListView.swift
//  MVVM-TodoList
//
//  Created by Nile Kelly on 20/01/2024.
//

import Foundation
import SwiftUI

struct ListView: View {
    //    passing environment object ListViewModel as a property on the view.
    //    This allows the view model's properties and methods to be accessed from the View, yet there is clear separation of concerns
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
//                animating between NoItemsView() and List
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    //            No need for 'ForEach(items, .\self)...' as ItemModel is Identifiable with its 'id' property
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Todo List 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddView())
        )
    }
}

// this code is just to setup previews
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        //        providing view model to preview. This is kind of mocking the app's environment so the preview works
        .environmentObject(ListViewModel())
    }
}
