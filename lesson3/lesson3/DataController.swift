//
//  DataController.swift
//  lesson3
//
//  Created by Jack Xia on 23/10/2023.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    // Matching name with Model
    let container = NSPersistentContainer(name: "Model")
    init() {
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            }
            print(description) // contains the SQLITE uri
        }
    }
}
