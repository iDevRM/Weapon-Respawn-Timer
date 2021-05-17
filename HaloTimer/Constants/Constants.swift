//
//  Constants.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/11/21.
//

import Foundation
import UIKit

struct Constants {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
}

enum RespawnTime: String {
    case fortyFiveSeconds    = "45"
    case thirySeconds        = "30"
    case oneMinute           = "60"
    case ninetySeconds       = "90"
    case twoMinutes          = "120"
    case twoAndAHalf         = "150"
    case threeMinutes        = "180"
}

enum WeaponName: String {
    case rocketLauncher = "Rocket Launcher"
    case sniperRifle    = "Sniper Rifle"
    case shotgun        = "Shotgun"
    case gravityHammer  = "Gravity Hammer"
    case bruteShot      = "Brute Shot"
    case spartanLaser   = "Spartan Laser"
    case energySword    = "Energy Sword"
    case missilePod     = "Missile Pod"
    case flamethrower   = "Flamethrower"
}

enum MapName: String {
    case assembly = "Assembly"
    case valhalla = "Valhalla"
    case guardian = "Guardian"
    case highGround = "High Ground"
    case citadel = "Citadel"
    case lastResort = "Last Resort"
    case sandbox = "Sandbox"
    case coldStorage = "Cold Storage"
    case blackout = "Blackout"
    case avalanche = "Avalanche"
    case longshore = "Longshore"
    case narrows = "Narrows"
    case construct = "Construct"
    case orbital = "Orbital"
    case ratsNest = "Rat's Nest"
    case epitaph = "Epitaph"
    case foundry = "Foundry"
    case sandtrap = "Sandtrap"
    case snowbound = "Snowbound"
    case standoff = "Standoff"
    case ghostTown = "Ghost Town"
    case heretic = "Heretic"
    case isolation = "Isolation"
    case thePit = "The Pit"
}

