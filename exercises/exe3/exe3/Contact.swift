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
