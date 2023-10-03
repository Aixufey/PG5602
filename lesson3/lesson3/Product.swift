//
//  Product.swift
//  lesson3
//
//  Created by Jack Xia on 04/09/2023.
//

import Foundation




struct Product: Identifiable, Codable {
    
    let id: UUID = UUID()
    
    let name: String
    let description: String
    let price: Int
    
    let images: [ProductImage]
    
    // CodingKeys has to conform with all declared fields
    // Using enum to declare Entity if the restAPI has weird names
    enum CodingKeys: String, CodingKey {
        case name
        case description = "Description"
        case price
        case images = "product_images"
        case id
    }
}

extension Product {
    static var sampleJSON: String {
        """
        {
          "name": "Bukse",
          "Description": "Grå",
          "price": 500,
          "product_images": [
            {
              "url": "https://www.google.com/",
              "description": "Bukse i grønn versjon"
            }
          ]
        }
        """
    }
}

// var shoppingCart: [Product] = []
var shoppingCart = [Product]() // () is to initialize the member, because Swift doesn't allow field value to be nil.


// This is globally available
// namespace this
extension Product {
    static let demoProducts = [
        Product.init(name: "Bukse", description: "Grå", price: 500, images: []),
        Product.init(name: "T-skjorte", description: "Blå", price: 400, images: []),
        Product.init(name: "Sko", description: "Hvit", price: 1090, images: [])
    ]
    
    
    static func testReturnProducts() -> [Product] {
        return [
            Product.init(name: "genser 1", description: "grønn med mønster", price: 890, images: []),
            Product.init(name: "genser 2", description: "rød med mønster", price: 890, images: []),
            Product.init(name: "genser 3", description: "blå med mønster", price: 890, images: [])
        ]
    }
}


// testReturnProduct() is static available
func aMethod() {
    let product1 = Product.demoProducts[0]
    //Product.testReturnProducts()
}
