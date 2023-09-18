//
//  AddContactView.swift
//  exe3
//
//  Created by Jack Xia on 14/09/2023.
//

import SwiftUI

struct AddContactView: View {
    
    var didAddContact: (Contact) -> ()
    
    init(didAddContact: @escaping (Contact) -> Void) {
        self.didAddContact = didAddContact
    }
    
    @State var newContactFName: String = ""
    @State var newContactLName: String = ""
    @State var isPresentingAddContactView: Bool
    
    
    
    
    func addContact() {
        if !newContactFName.isEmpty, !newContactLName.isEmpty {

            let newContact = Contact(firstName: newContactFName, lastName: newContactLName)
            didAddContact(newContact)
        }
    }
    
    var body: some View {
        
        // Sheet content View
        VStack {
            VStack {
                
                TextField("First name", text: $newContactFName)
                    .frame(width: 150)
                TextField("Last name", text: $newContactLName)
                    .frame(width: 150)
                
            }
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 120, height: 50)
                Text("Save")
                    .foregroundColor(.white)
            }.onTapGesture {
                addContact()
                print("Saving..")
                isPresentingAddContactView = false
            }
        }
        
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView() { contact in
            
        }
    }
}
