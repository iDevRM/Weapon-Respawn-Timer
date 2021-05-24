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
    
    var maps         = [Map]()
    var selectedMap:   Map?
    var didAnimate   = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate   = self
        tableView.dataSource = self
        setCustomFontsForTitles()
        loadMaps()
        
    }
        
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !didAnimate {
            performAnimations()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? TimerVC {
            destVC.selectedMap = self.selectedMap
        }
    }


}

//MARK: - Tableview Data Source and Delegate methods
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

//MARK: - Core Data Manipulation
extension MapsVC {
    
    func loadMaps() {
        let request: NSFetchRequest<Map> = Map.fetchRequest()
        
        do {
            maps = try Constants.context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
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

//MARK: - Helper Functions
extension MapsVC {
    
    func setCustomFontsForTitles() {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MyriadPro-Regular", size: 60) as Any]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MyriadPro-Regular", size: 35) as Any]
    }
    
    func performAnimations() {
        
        let navAnimation = AnimationType.vector(CGVector(dx: view.frame.maxX, dy: 0))
        let animation = AnimationType.vector(CGVector(dx: 0, dy: view.frame.height))
        UIView.animate(views: tableView.visibleCells,
                       animations: [animation], duration: 1.8)
        UIView.animate(views: [navigationController!.navigationBar], animations: [navAnimation], initialAlpha: 0.2, finalAlpha: 1, duration: 1.8)
        didAnimate = true
        
    }


    
}

