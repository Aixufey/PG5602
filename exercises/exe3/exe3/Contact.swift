//
//  File.swift
//  exe3
//
//  Created by Jack Xia on 06/09/2023.
//

import Foundation



struct Contact: Identifiable {
    let id: UUID = UUID()
    
    let firstName: String
    let lastName: String
    var description: String?
    var img: String?
    
    init(firstName: String, lastName: String, description: String? = nil, img: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.description = description
        self.img = img
    }
}

var contactList = [Contact]()

extension Contact {
    static let demoContacts = [
        Contact.init(firstName: "John", lastName: "Wick", description: "A very dangerous man", img: "coder"),
        Contact.init(firstName: "Motoko", lastName: "Kusanagi", description: "", img: "linux"),
        Contact.init(firstName: "Batou", lastName: "", description: "", img: "kodama"),
    ]
}
