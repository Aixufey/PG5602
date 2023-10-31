//
//  StoreTest.swift
//  lesson3Tests
//
//  Created by Jack Xia on 31/10/2023.
//

import XCTest
@testable import lesson3

final class StoreTest: XCTestCase {
    
    
    // Clean up Database before each test
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let fetchRequest = Store.fetchRequest()
        let results = try
        DataController.shared.container.viewContext.fetch(fetchRequest)
        
        for object in results {
            DataController.shared.container.viewContext.delete(object)
        }
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testParseStore() throws {
        let json =
        """
        {
          "name": "Urtegata klesbutikk",
          "openingHours": "Man-Fre 08:00 - 17:00",
          "longitude": 50.755,
          "latitude": 45.123
        }
        """
        let decoder = JSONDecoder()
        let store = try decoder.decode(Store.self, from: json.data(using: .utf8)!)
        
        let request = Store.fetchRequest()
        
        let results = try DataController.shared.container.viewContext.fetch(request)
        XCTAssertEqual(results.count, 1)
        
        let fetchedStore = results[0]
        XCTAssertEqual(fetchedStore.name, "Urtegata klesbutikk")
        XCTAssertEqual(fetchedStore.latitude, 45.123)
        
    }
    
}
