//
//  ViewController.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/11/21.
//

import UIKit
import CoreData
import ViewAnimator

class MapsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var maps = [Map]()
    var selectedMap:   Map?
    var timer        = Timer()
    var didAnimate   = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate   = self
        tableView.dataSource = self
        loadMaps()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !didAnimate {
            let navAnimation = AnimationType.vector(CGVector(dx: view.frame.maxX, dy: 0))
            let animation = AnimationType.vector(CGVector(dx: 0, dy: view.frame.height))
            UIView.animate(views: tableView.visibleCells,
                           animations: [animation], duration: 1.8)
            UIView.animate(views: [navigationController!.navigationBar], animations: [navAnimation], initialAlpha: 0.2, finalAlpha: 1, duration: 1.8)
            didAnimate = true
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? TImerVC {
            destVC.selectedMap = self.selectedMap
        }
    }


}

extension MapsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maps.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell", for: indexPath) as? MapCell {
            cell.configCell(with: maps.sorted { $0.mapName! < $1.mapName! }[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMap = maps.sorted { $0.mapName! < $1.mapName!}[indexPath.row]
        performSegue(withIdentifier: "timerSegue", sender: nil)
    }
    
    
}

extension MapsVC {
    
    func loadMaps() {
        let request: NSFetchRequest<Map> = Map.fetchRequest()
        
        do {
            maps = try Constants.context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchWeapons(for mapName: String) -> [Weapon] {
        var secondArray = [Weapon]()
        let weaponRequest: NSFetchRequest<Weapon> = Weapon.fetchRequest()
        let predicate = NSPredicate(format: "maps.mapName CONTAINS[cd] %@", mapName)
        
        weaponRequest.predicate = predicate
        
        do {
            let firstArray = try Constants.context.fetch(weaponRequest)
            
            for weapon in firstArray {
                if weapon.respawnTime != nil {
                    secondArray.append(weapon)
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
        return secondArray
    }
    
    func save() {
        
        do {
            try Constants.context.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func removeAllMaps(at index: Int) {

        Constants.context.delete(maps[index])
        maps.remove(at: index)
        save()
        
    }
    
  
    
}

