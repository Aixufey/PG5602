//
//  ContentView.swift
//  exe3
//
//  Created by Jack Xia on 04/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    let contacts = [
        Contact.init(firstName: "John", lastName: "Wick", description: "A very dangerous man", img: "coder"),
        Contact.init(firstName: "Motoko", lastName: "Kusanagi", description: "", img: "linux"),
        Contact.init(firstName: "Batou", lastName: "", description: "", img: "kodama"),
    ]
    
    
    var body: some View {
        NavigationStack {
            
            // Refactored this List into a separated file.
            // ContactVerticalListView(contacts: contacts)
            
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                        ForEach(contacts) { ele in
                            CardView(tag: "⚠️",img: ele.img ?? "coder", fName: ele.firstName, lName: ele.lastName, desc: ele.description ?? "").padding(50)
                            
                        }
                    }
                    .padding(25)
                }
            }
            
            
        } // nav stack
    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




