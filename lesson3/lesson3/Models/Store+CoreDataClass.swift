//
//  Store+CoreDataClass.swift
//  lesson3
//
//  Created by Jack Xia on 31/10/2023.
//
//

import Foundation
import CoreData

@objc(Store)



public class Store: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case name
        case longitude
        case latitude
        case openingHours
    }
    
    // Insert into database and check if the entities exist that conforms our CodingKeys
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    
    public required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decodeIfPresent(String.self, forKey: .name)
        let longitude = try container.decode(Float.self, forKey: .longitude)
        let latitude = try container.decode(Float.self, forKey: .latitude)
        let openingHour = try container.decodeIfPresent(String.self, forKey: .openingHours)
        
        let managedObjectContext = NSManagedObjectContext(.mainQueue)
        
        super.init(entity:
                .entity(forEntityName: "Store", in:
                            managedObjectContext)!,
                   insertInto: managedObjectContext)
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.openingHour = openingHour
    }
}
