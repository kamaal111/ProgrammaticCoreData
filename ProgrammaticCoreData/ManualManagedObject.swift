//
//  ManualManagedObject.swift
//  ProgrammaticCoreData
//
//  Created by Kamaal M Farah on 13/11/2022.
//

import CoreData

protocol ManualManagedObject {
    static var entity: NSEntityDescription { get }
}
