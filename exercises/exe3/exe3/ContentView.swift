//
//  ContentView.swift
//  exe3
//
//  Created by Jack Xia on 04/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    let contacts = [
        Contact.init(firstName: "John", lastName: "Wick", description: "A very dangerous man"),
        Contact.init(firstName: "Motoko", lastName: "Kusanagi"),
        Contact.init(firstName: "Batou", lastName: ""),
    ]
    
    
    var body: some View {
        NavigationStack {
            
            List {
                
                ForEach(contacts) {ele in
                    // Route to a new "view"
                    NavigationLink {
                        VStack {
                            Text(ele.firstName)
                            Text(ele.lastName)
                        }
                        // label = placeholder for each rows in the list
                    } label: {
                        
                        ContactRowView(contact: ele)
                        
                        
                    } // label
                } // foreach
            } // list
            
        } // nav stack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct Contact: Identifiable {
    let id: UUID = UUID()
    
    let firstName: String
    let lastName: String
    var description: String?
    
    init(firstName: String, lastName: String, description: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.description = description
    }
}
