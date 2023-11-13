//
//  APIClient.swift
//  lesson3
//
//  Created by Jack Xia on 09/10/2023.
//

import Foundation
import MapKit

struct APIClient {
    
    var getProducts: ( () async throws -> [Product] )
    
    //
    var purchaseProducts: ( ([Product]) async throws -> () )
    
    // func getProducts() -> [Product] {} function returning array of products is equivalent to closure declaration
    
    // Endpoint for StoreView and Map
    var getStores: (() async throws -> [Store])
    
    
    // Shipping Address
    var updateAddress: (_ address: String, _ postalCode: String) async throws -> ()
    
}

enum APIClientError: Error {
    case failed(underlying: Error)
    case statusCode(Int)
    case insufficientFunds
    case stolenCard
    case unknown
}
extension APIClient {
    // Trailing closure with explicit getProducts
    static let live = APIClient(getProducts: {
        
        var url = URL(string:
                        "https://raw.githubusercontent.com/BeiningBogen/PG5602/master/products.json")!
        // Returns an object type
        let (data, response) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode([Product].self, from: data)
        
        return products
        
    }, purchaseProducts: { products in
        var url = URL(string:
                        "https://raw.githubusercontent.com/BeiningBogen/PG5602/master/products.json")!
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = "POST"
        
        // Inside closure, for each product in purchaseProduct function do:
        // Encoding our query parameters as 'data and post into body
        let query = try JSONEncoder().encode(products)
        urlRequest.httpBody = query
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // If the status code is not 200 throw custom error
        if let statusCode = (response as? HTTPURLResponse)?.statusCode,
           statusCode != 200 {
            throw APIClientError.statusCode(statusCode)
        }
    }, getStores: {
        var url = URL(string: "https://www.google.com")!
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["Accept": "application/json", "Content-Type": "application/json"]
        
        let (data, resp) = try await URLSession.shared.data(from: url)
        
        if let statusCode = (resp as? HTTPURLResponse)?.statusCode {
            switch statusCode {
            case 200...299:
                // client
                return try JSONDecoder().decode([Store].self, from: data)
            default:
                throw APIClientError.statusCode(statusCode)
            }
        }
        throw APIClientError.unknown
    }) { address, postalCode in
        // Quick way to write a struct to post this body
        struct UpdateAddressParameter: Encodable {
            let address: String
            let postalCode: String
        }
        var urlRequest = URLRequest.init(url: URL(string: "dasda")!)
        urlRequest.httpMethod = "PUT"
        let parameter = UpdateAddressParameter(address: address, postalCode: postalCode)
        urlRequest.httpBody = try JSONEncoder().encode(parameter)
        
    }
    
    
    static let demo = APIClient(getProducts: {
        let product = Product.init(name: "Tøfler", description: "Grå", price: 1000, images: [ProductImage]())
        let product2 = Product.init(name: "Våtter", description: "Grønn", price: 299, images: [ProductImage]())
        
        return [product, product2]
        
    }, purchaseProducts: { product in
        // throw APIClientError.stolenCard
        return
    }, getStores: {
//        var store = Store()
//        store.name = "Test store 1"
//        store.longitude = 10.191
//        store.latitude = 9.3123
//        store.openingHour = "Mon-Sat 10:00 - 18:00"
        return []
    }, updateAddress: {_, _ in
        
    } )
    
    
    // Manual testing simulation of throwing Errors from Enum
    // To test initiate as APIClient.error(.stolenCard) to render in Preview
    static func error(_ error: APIClientError) -> APIClient {
        APIClient {
            throw error
        } purchaseProducts: { _ in
            throw error
        } getStores: {
            throw error
        } updateAddress: { address, postalCode in
            throw error
        }
    }
}
