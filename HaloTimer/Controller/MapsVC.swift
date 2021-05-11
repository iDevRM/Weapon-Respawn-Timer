//
//  ViewController.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/11/21.
//

import UIKit
import CoreData

class MapsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var maps = [Map]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadMaps()
        print(maps.count)
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
            cell.configCell(with: maps[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
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
    
    func save() {
        
        do {
            try Constants.context.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}

