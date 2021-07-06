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
    @NSManaged public var maps: Map?

}

extension Weapon : Identifiable {

}
