//
//  lesson3Tests.swift
//  lesson3Tests
//
//  Created by Jack Xia on 26/09/2023.
//

import XCTest
@testable import lesson3

final class lesson3Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidProductFromJSON() {
           let json = Product.sampleJSON
           let decoder = JSONDecoder()
           do {
               let product = try decoder.decode(Product.self, from: json.data(using: .utf8)!)

               XCTAssertEqual(product.name, "Bukse")
               XCTAssertEqual(product.description, "Grå")
               XCTAssertEqual(product.price, 500)
               XCTAssertEqual(product.images.count, 1)
               
               let prodImg = product.images.first
               
               XCTAssertEqual(prodImg?.url, "https://www.google.com/")
               XCTAssertEqual(prodImg?.description, "Bukse i grønn versjon")
               
           } catch let error {
               XCTFail(error.localizedDescription)
           }
       }
    
    func testInvalidJSON() {
        let json =
                """
                {
                  "name": "Bukse",
                  "Description": "Grå",
                }
                """
        let decoder = JSONDecoder()
        do {
            let _ = try decoder.decode(Product.self, from: json.data(using: .utf8)!)
            XCTFail("Should not make a product without price")
        } catch {
            
        }
    }
    
    func testJSONWithAThrow() throws {
        let jsonArray = [
                """
                {
                  "name": "Bukse",
                  "Description": "Grå",
                  "price": 500,
                  "product_images" : [{"url": "", "description": ""}]
                },
                {
                  "name": "Bukse",
                  "Description": "Grå",
                  "price": 1100,
                  "product_images" : [{"url": "", "description": ""}]
                },
                {
                  "name": "Bukse",
                  "Description": "Grå",
                  "price": 100,
                  "product_images" : [{"url": "", "description": ""}]
                },
                {
                  "name": "Bukse",
                  "Description": "Grå",
                  "price": 300,
                  "product_images" : [{"url": "", "description": ""}]
                }
                                
                """
        ]
        
        var productArray: [Product] = []
        
        for obj in jsonArray {
            if let data = obj.data(using: .utf8) {
                
                let decoder = JSONDecoder()
                if let product = try? decoder.decode(Product.self, from: data) {
                    productArray.append(product)
                }
            }
                
        }
        
        
        for prod in productArray {
            // All price MUST be over 0
            XCTAssertGreaterThan(prod.price, 0)
            // All items must have a name
            XCTAssertNotNil(prod.name, "")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
