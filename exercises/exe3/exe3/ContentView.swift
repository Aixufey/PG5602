//
//  ContentView.swift
//  exe3
//
//  Created by Jack Xia on 04/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var contacts = [
        Contact.init(firstName: "John", lastName: "Wick", description: "A very dangerous man", img: "coder"),
        Contact.init(firstName: "Motoko", lastName: "Kusanagi", description: "", img: "linux"),
        Contact.init(firstName: "Batou", lastName: "", description: "", img: "kodama"),
    ]
    
    // Button to add contact
    @State var newContactFName: String = ""
    @State var newContactLName: String = ""
    
    // Sheets is showing if true
    @State var isPresentingAddContactView: Bool
    // But at load set to false
    init(isPresentingAddContactView: Bool = false) {
        self.isPresentingAddContactView = isPresentingAddContactView
    }
    
    func addContact() {
        let newContact = Contact(firstName: newContactFName, lastName: newContactLName)
        contacts.append(newContact)
        print(contacts)
    }
    
    var body: some View {
        NavigationStack {
            // Refactored this List into a separated file.
             ContactVerticalListView(contacts: contacts)
            
            
            // Add contact button View
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 120, height: 50)
                    Text("Add contact")
                        .foregroundColor(.white)
                }.onTapGesture {
                    isPresentingAddContactView = true
                    print("Sheet showing")
                }
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
                
            } // add new Contact button
            .sheet(isPresented: $isPresentingAddContactView) {
                
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
                
            } // Sheet
            
            
            
            
            
            
            
            // TODO: Need to refactor this into a horizontal View
//            VStack {
//                ScrollView(.horizontal, showsIndicators: false) {
//
//                    HStack {
//                        ForEach(contacts) { ele in
//                            CardView(tag: "⚠️",img: ele.img ?? "coder", fName: ele.firstName, lName: ele.lastName, desc: ele.description ?? "").padding(50)
//
//                        }
//                    }
//                    .padding(25)
//                }
//            }
            
        } // nav stack
        
    } // body
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




