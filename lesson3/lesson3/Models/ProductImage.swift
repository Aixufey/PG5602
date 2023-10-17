//
//  ProductImage.swift
//  lesson3
//
//  Created by Jack Xia on 26/09/2023.
//

import Foundation





struct ProductImage: Codable, Identifiable {
    
    let id: UUID = UUID()
    
    let description: String
    let url: String
}
