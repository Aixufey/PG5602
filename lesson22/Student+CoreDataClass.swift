//
//  Student+CoreDataClass.swift
//  lesson22
//
//  Created by Jack Xia on 07/11/2023.
//
//

import Foundation
import CoreData

@objc(Student)
public class Student: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case name
        case school
    }
    
    public required init(from decoder: Decoder) throws {
        let moc = PersistenceController.shared.container.viewContext
    
        super.init(entity:
                .entity(forEntityName: "Student", in: moc)!,
                   insertInto: moc)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decodeIfPresent(String.self, forKey: CodingKeys.name)
    }
}
