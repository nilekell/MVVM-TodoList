//
//  MVVM_TodoListApp.swift
//  MVVM-TodoList
//
//  Created by Nile Kelly on 20/01/2024.
//

import SwiftUI

/*
 MVVM Architecture
 
 Model - data point
 View - UI
 ViewModel - manages Models for View
 */

@main
struct MVVM_TodoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
//            fixing ipad display
            .navigationViewStyle(StackNavigationViewStyle())
//          All items in navigation view have access to this listview model          when you add it as an environment object
//          To just provide the view model to the ListView, you pass it in the constructor
            .environmentObject(listViewModel)
        }
    }
}
