//
//  AppDelegate.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/11/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        preloadData()
       
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func preloadData() {
        let preloadedDataKey = "preloadData"
        let userDefualts = UserDefaults.standard
        
        
        if userDefualts.bool(forKey: preloadedDataKey) == false {
            guard let urlPath = Bundle.main.url(forResource: "Maps", withExtension: "plist"),
                  let urlPath2 = Bundle.main.url(forResource: "Weapons", withExtension: "plist") else { return }
            
            let backgroundContext = persistentContainer.newBackgroundContext()
            Constants.context.automaticallyMergesChangesFromParent = true
            
            backgroundContext.perform {
                
                if let arrayOfMaps = NSArray(contentsOf: urlPath) as? [String],
                   let arrayOfWeapons = NSArray(contentsOf: urlPath2) as? [String] {
                    
                    var setOfWeapons = Set<Weapon>()
                   
                    do {
                        
                        for mapName in arrayOfMaps {
                            setOfWeapons.removeAll()
                            let newMap = Map(context: backgroundContext)
                            for weaponName in arrayOfWeapons {
                                let newWeapon = Weapon(context: backgroundContext)
                                newWeapon.name = weaponName
                                setOfWeapons.insert(newWeapon)
                            }
                            newMap.mapName = mapName
                            newMap.imageName = mapName
                            newMap.weapons = setOfWeapons as NSSet
                            newMap.weapons = addRespawnValues(to: newMap) as NSSet
                           
                        }
                        
                        try backgroundContext.save()
                        
                        
                        
                        userDefualts.set(true, forKey: preloadedDataKey)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
            }
        }
        
        func addRespawnValues(to map: Map) -> Set<Weapon> {
            guard let mapSet = map.weapons as? Set<Weapon> else { return Set<Weapon>()}
            
            var weaponSet = Set<Weapon>()
            
            switch map.mapName! {
                case MapName.assembly.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.ninetySeconds.rawValue
                            case WeaponName.gravityHammer.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }
                    
                case MapName.avalanche.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.oneMinute.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.oneMinute.rawValue
                            case WeaponName.spartanLaser.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.fortyFiveSeconds.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }
                    
                case MapName.blackout.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.energySword.rawValue:
                                weapon.respawnTime = RespawnTime.twoAndAHalf.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }
                    
                case MapName.citadel.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.oneMinute.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }
                    
                case MapName.coldStorage.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }
                    
                case MapName.construct.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.spartanLaser.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.thirySeconds.rawValue
                            case WeaponName.energySword.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.missilePod.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.flamethrower.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }
                    
                case MapName.epitaph.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.ninetySeconds.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }
                    
                case MapName.foundry.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.ninetySeconds.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.ninetySeconds.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.thirySeconds.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }
                    
                case MapName.ghostTown.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.ninetySeconds.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }
                    
                case MapName.guardian.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.gravityHammer.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.heretic.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.energySword.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.highGround.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.ninetySeconds.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.ninetySeconds.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.spartanLaser.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.isolation.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.thirySeconds.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.thirySeconds.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.lastResort.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.ninetySeconds.rawValue
                            case WeaponName.spartanLaser.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.oneMinute.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.longshore.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.energySword.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.narrows.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.twoAndAHalf.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.ninetySeconds.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.orbital.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.ratsNest.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.twoAndAHalf.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.oneMinute.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.oneMinute.rawValue
                            case WeaponName.gravityHammer.rawValue:
                                weapon.respawnTime = RespawnTime.ninetySeconds.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.sandbox.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.ninetySeconds.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.oneMinute.rawValue
                            case WeaponName.missilePod.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.sandtrap.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.thirySeconds.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.spartanLaser.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.thirySeconds.rawValue
                            case WeaponName.missilePod.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.gravityHammer.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.snowbound.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.beamRifle.rawValue:
                                weapon.respawnTime = RespawnTime.twoAndAHalf.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.oneMinute.rawValue
                            case WeaponName.spartanLaser.rawValue:
                                weapon.respawnTime = RespawnTime.twoAndAHalf.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.oneMinute.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.standoff.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.spartanLaser.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.fortyFiveSeconds.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.thePit.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.rocketLauncher.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            case WeaponName.energySword.rawValue:
                                weapon.respawnTime = RespawnTime.twoMinutes.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }

                case MapName.valhalla.rawValue:
                    for weapon in mapSet {
                        switch weapon.name! {
                            case WeaponName.sniperRifle.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.shotgun.rawValue:
                                weapon.respawnTime = RespawnTime.ninetySeconds.rawValue
                            case WeaponName.spartanLaser.rawValue:
                                weapon.respawnTime = RespawnTime.threeMinutes.rawValue
                            case WeaponName.bruteShot.rawValue:
                                weapon.respawnTime = RespawnTime.thirySeconds.rawValue
                            case WeaponName.missilePod.rawValue:
                                weapon.respawnTime = RespawnTime.twoAndAHalf.rawValue
                            default:
                                weapon.respawnTime = nil
                                break
                        }
                        weaponSet = mapSet
                    }
                    
                default:
                    break
            }
            return weaponSet
        }
    
        
    }
    
    
    
    
    



    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "HaloTimer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

