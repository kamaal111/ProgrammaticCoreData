//
//  ManualManagedObject.swift
//  ProgrammaticCoreData
//
//  Created by Kamaal M Farah on 13/11/2022.
//

import CoreData

protocol ManualManagedObject: NSManagedObject {
    static var entityName: String { get }
    static var properties: [ManagedObjectPropertyConfiguration] { get }
}

extension ManualManagedObject {
    static var entity: NSEntityDescription {
        // Create the entity
        let entity = NSEntityDescription()
        entity.name = entityName
        entity.managedObjectClassName = entityName

        // Create the attributes
        entity.properties = properties.map(\.attribute)

        return entity
    }

    static func fetchRequest() -> NSFetchRequest<Self> {
        NSFetchRequest<Self>(entityName: entityName)
    }
}

struct ManagedObjectPropertyConfiguration {
    let name: String
    let type: PropertyType
    let isOptional: Bool

    enum PropertyType {
        case date
        case uuid

        fileprivate var nsAttributeType: NSAttributeType {
            switch self {
            case .date:
                return .dateAttributeType
            case .uuid:
                return .UUIDAttributeType
            }
        }
    }

    var attribute: NSAttributeDescription {
        let attribute = NSAttributeDescription()
        attribute.name = name
        attribute.attributeType = type.nsAttributeType
        attribute.isOptional = isOptional
        return attribute
    }
}
