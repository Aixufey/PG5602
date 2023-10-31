//
//  Store+CoreDataProperties.swift
//  lesson3
//
//  Created by Jack Xia on 31/10/2023.
//
//

import Foundation
import CoreData


extension Store {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store")
    }

    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float
    @NSManaged public var name: String?
    @NSManaged public var openingHour: String?

}

extension Store : Identifiable {

}
