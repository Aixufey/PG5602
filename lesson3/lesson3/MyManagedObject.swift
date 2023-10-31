//
//  MyManagedObject.swift
//  lesson3
//
//  Created by Jack Xia on 30/10/2023.
//

import Foundation
import CoreData


class MyManagedObject: NSManagedObject {
    @NSManaged var property: String?

    enum CodingKeys: String, CodingKey {
       case property = "json_key"
    }
}
