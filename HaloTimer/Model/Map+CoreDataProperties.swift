//
//  Map+CoreDataProperties.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/11/21.
//
//

import Foundation
import CoreData


extension Map {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Map> {
        return NSFetchRequest<Map>(entityName: "Map")
    }

    @NSManaged public var imageName: String?
    @NSManaged public var mapName: String?
    @NSManaged public var weapons: NSSet?

}

// MARK: Generated accessors for weapons
extension Map {

    @objc(addWeaponsObject:)
    @NSManaged public func addToWeapons(_ value: Weapon)

    @objc(removeWeaponsObject:)
    @NSManaged public func removeFromWeapons(_ value: Weapon)

    @objc(addWeapons:)
    @NSManaged public func addToWeapons(_ values: NSSet)

    @objc(removeWeapons:)
    @NSManaged public func removeFromWeapons(_ values: NSSet)

}

extension Map : Identifiable {

}
