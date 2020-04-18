//
//  Note+CoreDataClass.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/18/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject, Codable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }
    
    @NSManaged public var userNote: String?
    @NSManaged public var userId: Int32
    
    enum CodingKeys: String, CodingKey {
        case userNote
        case userId
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedObjectContext) else {
                fatalError("Failed to decode Note")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userNote = try values.decodeIfPresent(String.self, forKey: .userNote)
        userId = try values.decodeIfPresent(Int32.self, forKey: .userId) ?? 0
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userNote, forKey: .userNote)
        try container.encode(userId, forKey: .userId)
    }
}

