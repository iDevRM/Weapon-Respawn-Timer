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
        preloadMapImageNames()
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
        let preloadedDataKey = "pre-loadedData"
        let userDefualts = UserDefaults.standard
        
        if userDefualts.bool(forKey: preloadedDataKey) == false {
            guard let urlPath = Bundle.main.url(forResource: "Maps", withExtension: "plist") else { return }
            
            let backgroundContext = persistentContainer.newBackgroundContext()
            Constants.context.automaticallyMergesChangesFromParent = true
            
            backgroundContext.perform {
                
                if let arrayOfMaps = NSArray(contentsOf: urlPath) as? [String] {
                    
                    do {
                        for item in arrayOfMaps {
                            let newMap = Map(context: backgroundContext)
                            newMap.mapName = item
                        }
                        
                        try backgroundContext.save()
                        
                        userDefualts.set(true, forKey: preloadedDataKey)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }

    }
    
    private func preloadMapImageNames() {
        let preloadedDataKey = "pre-loadMapImageNames"
        let userDefualts = UserDefaults.standard
        
        if userDefualts.bool(forKey: preloadedDataKey) == false {
            guard let urlPath = Bundle.main.url(forResource: "MapImageNames", withExtension: "plist") else { return }
            
            let backgroundContext = persistentContainer.newBackgroundContext()
            Constants.context.automaticallyMergesChangesFromParent = true
            
            backgroundContext.perform {
                
                if let mapImageNames = NSArray(contentsOf: urlPath) as? [String] {
                    let request: NSFetchRequest<Map> = Map.fetchRequest()
                    do {
                        
                        let maps = try Constants.context.fetch(request)
                        
                        for mapName in mapImageNames {
                            for map in maps {
                                if mapName == map.mapName {
                                    map.imageName = mapName
                                    print(map)
                                }
                            }
                        }
                        
                        try backgroundContext.save()
                        try Constants.context.save()
                        userDefualts.set(true, forKey: preloadedDataKey)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
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

