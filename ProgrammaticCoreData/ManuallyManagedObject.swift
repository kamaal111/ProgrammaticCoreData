//
//  ManuallyManagedObject.swift
//  ProgrammaticCoreData
//
//  Created by Kamaal M Farah on 13/11/2022.
//

import CoreData

protocol ManuallyManagedObject: NSManagedObject {
    static var entityName: String { get }
    static var properties: [ManagedObjectPropertyConfiguration] { get }
}

extension ManuallyManagedObject {
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

    init(name: String, type: PropertyType, isOptional: Bool) {
        self.name = name
        self.type = type
        self.isOptional = isOptional
    }

    init<Root: ManuallyManagedObject, Value>(name: KeyPath<Root, Value>, type: PropertyType, isOptional: Bool) {
        self.init(name: NSExpression(forKeyPath:  name).keyPath, type: type, isOptional: isOptional)
    }

    enum PropertyType {
        case date
        case uuid
        case url
        case data
        case bool
        case string
        case float
        case double
        case int64
        case int32
        case int16

        fileprivate var nsAttributeType: NSAttributeType {
            switch self {
            case .date:
                return .dateAttributeType
            case .uuid:
                return .UUIDAttributeType
            case .url:
                return .URIAttributeType
            case .data:
                return .binaryDataAttributeType
            case .bool:
                return .booleanAttributeType
            case .string:
                return .stringAttributeType
            case .float:
                return .floatAttributeType
            case .double:
                return .doubleAttributeType
            case .int64:
                return .integer64AttributeType
            case .int32:
                return .integer32AttributeType
            case .int16:
                return .integer16AttributeType
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
