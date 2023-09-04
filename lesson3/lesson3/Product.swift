//
//  Product.swift
//  lesson3
//
//  Created by Jack Xia on 04/09/2023.
//

import Foundation




struct Product: Identifiable {
    let id: UUID = UUID()
    
    let name: String
    let description: String
    let price: Int
}

func testProd() {
    let prod1 = Product(name: "test", description: "test", price: 0)
}
