//
//  Teacher+CoreDataClass.swift
//  lesson22
//
//  Created by Jack Xia on 07/11/2023.
//
//

import Foundation
import CoreData

@objc(Teacher)
public class Teacher: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case name
        case school
    }
    
    public required init(from decoder: Decoder) throws {
        let moc = PersistenceController.shared.container.viewContext
        
        let schools = try moc.fetch(School.fetchRequest())
        let teachers = try moc.fetch(Teacher.fetchRequest())
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // If teacher already exist dont insert
        let name = try container.decode(String.self, forKey: .name)
        if teachers.contains(where: { $0.name == name } ) {
            throw DatabaseErr.duplicateError
        } else {
            super.init(entity:
                    .entity(forEntityName: "Teacher", in: moc)!,
                       insertInto: moc)
            self.name = name
            
            // Get school id from DB
            let id = try container.decode(Int.self, forKey: .school)
            let school = schools.first(where: {$0.id == id})
            school?.addToTeachers(self)
        }
        
    }
}
enum DatabaseErr: Error {
    case duplicateError
}
