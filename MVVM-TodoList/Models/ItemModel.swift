//
//  ItemModel.swift
//  MVVM-TodoList
//
//  Created by Nile Kelly on 20/01/2024.
//

import Foundation

// ItemModel conforms to Identifiable Protocol
// ItemModel conforms to Codable Protocol, enabling ItemModel to be encoded/decoded to data.
// Allows this model to be used in ForEach loop
// This is an immutable struct therefore 'let' properties never change

struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
//    setting default value of id in case it is not passed as an argument
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
//    all logic to update model is encapsulated within the model definition itself
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}

/*
ItemModel has two different initialisers:

ItemModel(title: <#T##String#>, isCompleted: <#T##Bool#>)
ItemModel(id: <#T##String#>, title: <#T##String#>, isCompleted: <#T##Bool#>)
*/
