//
//  Item.swift
//  ProgrammaticCoreData
//
//  Created by Kamaal M Farah on 13/11/2022.
//

import CoreData

@objc(Item)
public class Item: NSManagedObject, ManualManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var timestamp: Date

    static let entityName = "Item"

    static let properties: [ManagedObjectPropertyConfiguration] = [
        .init(name: "timestamp", type: .date, isOptional: false),
        .init(name: "id", type: .uuid, isOptional: false)
    ]
}
