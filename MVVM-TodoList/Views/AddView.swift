//
//  AddView.swift
//  MVVM-TodoList
//
//  Created by Nile Kelly on 20/01/2024.
//

import SwiftUI

struct AddView: View {
//    This presentationMode comes by default with all views in SwiftUI. This presentationMode monitors which the view is in the view hierarchy. Using presentationMode, we can always 'go back' a View in our view hierarchy
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var listViewModel: ListViewModel
    
// state binding variable which updates itself with contents of TextField
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(.gray).opacity(0.4))
                    .cornerRadius(10)
                
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
                	
            }
            .padding(14)
        }
        .navigationTitle("Add an item 🖊️")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if textIsValid() {
            listViewModel.addItem(title: textFieldText)
    //        Go back one view in the view hierarchy
            presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    func textIsValid() -> Bool {
        if (textFieldText.count < 3) {
            alertTitle = "Your new todo must be at least 3 characters long! 😭"
            showAlert.toggle()
            return false
        }
        
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
