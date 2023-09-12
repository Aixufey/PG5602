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

// var shoppingCart: [Product] = []
var shoppingCart = [Product]() // () is to initialize the member, because Swift doesn't allow field value to be nil.


// This is globally available
// namespace this
extension Product {
    static let demoProducts = [
        Product.init(name: "Bukse", description: "Grå", price: 500),
        Product.init(name: "T-skjorte", description: "Blå", price: 400),
        Product.init(name: "Sko", description: "Hvit", price: 1090)
    ]
    
    
    static func testReturnProducts() -> [Product] {
        return [
            Product.init(name: "genser 1", description: "grønn med mønster", price: 890),
            Product.init(name: "genser 2", description: "rød med mønster", price: 890),
            Product.init(name: "genser 3", description: "blå med mønster", price: 890)
        ]
    }
}


// testReturnProduct() is static available
func aMethod() {
    let product1 = Product.demoProducts[0]
    //Product.testReturnProducts()
}
