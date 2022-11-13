//
//  Item.swift
//  ProgrammaticCoreData
//
//  Created by Kamaal M Farah on 13/11/2022.
//

import CoreData

@objc(Item)
public class Item: NSManagedObject, ManualManagedObject {
    static let entityName = "Item"

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        NSFetchRequest<Item>(entityName: entityName)
    }

    @NSManaged public var id: UUID
    @NSManaged public var timestamp: Date

    static let entity: NSEntityDescription = {
        // Create the entity
        let entity = NSEntityDescription()
        entity.name = entityName
        entity.managedObjectClassName = entityName

        // Create the attributes
        var properties: [NSPropertyDescription] = []

        let timestampAttribute = NSAttributeDescription()
        timestampAttribute.name = "timestamp"
        timestampAttribute.attributeType = .dateAttributeType
        timestampAttribute.isOptional = false
        properties.append(timestampAttribute)

        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .UUIDAttributeType
        idAttribute.isOptional = false
        properties.append(idAttribute)

        // Add properties to entity
        entity.properties = properties

        return entity
    }()
}
