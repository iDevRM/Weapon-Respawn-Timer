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
    @NSManaged public var map: NSSet?

}

// MARK: Generated accessors for map
extension Weapon {

    @objc(addMapObject:)
    @NSManaged public func addToMap(_ value: Map)

    @objc(removeMapObject:)
    @NSManaged public func removeFromMap(_ value: Map)

    @objc(addMap:)
    @NSManaged public func addToMap(_ values: NSSet)

    @objc(removeMap:)
    @NSManaged public func removeFromMap(_ values: NSSet)

}

extension Weapon : Identifiable {

}
