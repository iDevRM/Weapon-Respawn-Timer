//
//  Weapon+CoreDataProperties.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/18/21.
//
//

import Foundation
import CoreData


extension Weapon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weapon> {
        return NSFetchRequest<Weapon>(entityName: "Weapon")
    }

    @NSManaged public var name: String?
    @NSManaged public var respawnTime: String?
    @NSManaged public var maps: NSSet?

}

// MARK: Generated accessors for maps
extension Weapon {

    @objc(addMapsObject:)
    @NSManaged public func addToMaps(_ value: Map)

    @objc(removeMapsObject:)
    @NSManaged public func removeFromMaps(_ value: Map)

    @objc(addMaps:)
    @NSManaged public func addToMaps(_ values: NSSet)

    @objc(removeMaps:)
    @NSManaged public func removeFromMaps(_ values: NSSet)

}

extension Weapon : Identifiable {

}
