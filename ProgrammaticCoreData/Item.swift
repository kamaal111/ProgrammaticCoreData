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

    static let entity: NSEntityDescription = {
        // Create the entity
        let entity = NSEntityDescription()
        entity.name = entityName
        entity.managedObjectClassName = entityName

        // Create the attributes
        let timestampAttribute = NSAttributeDescription()
        timestampAttribute.name = "timestamp"
        timestampAttribute.attributeType = .dateAttributeType
        timestampAttribute.isOptional = false

        // Add properties to entity
        entity.properties = [
            timestampAttribute
        ]

        return entity
    }()
}
