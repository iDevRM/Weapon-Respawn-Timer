//
//  TImerVC.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/13/21.
//

import UIKit
import CoreData
import Foundation

class TImerVC: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timerBackgroundView: UIView!
    
    @IBOutlet weak var pictureBackroundView: UIView!
    
    @IBOutlet weak var pictureVIew: UIImageView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var infoButton: UIBarButtonItem!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var selectedMap: Map?
    
    var weaponArray = [Weapon]()
    var weaponSet   = Set<Weapon>()
    var timer: Timer?
    
    var weaponRespawnTime = 0
    var timeRemaining     = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in weaponArray {
            print(i.name!,i.respawnTime!)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        loadWeaponsFromSelectedMap()
        
        if let firstWeapon = weaponArray.first {
            pictureVIew.image = UIImage(named: firstWeapon.name!)
        }
       
        startButton.layer.cornerRadius = 10
        startButton.backgroundColor = #colorLiteral(red: 0.5081628561, green: 0.7110635638, blue: 0.4669082761, alpha: 1)
        backgroundView.backgroundColor = #colorLiteral(red: 0.3257828355, green: 0.5983628631, blue: 0.7235913277, alpha: 1)
        pictureBackroundView.layer.cornerRadius = 10
        backgroundImageView.layer.cornerRadius = 10
        collectionView.layer.cornerRadius = 10
        timerBackgroundView.layer.cornerRadius = 10
        timerLabel.backgroundColor = UIColor.black
        timerLabel.layer.cornerRadius = 10
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    
    
    @IBAction func infoButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        if sender.currentTitle == "Start" {
            timeRemaining = weaponRespawnTime
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            timer!.fire()
            sender.setTitle("Stop", for: .normal)
        } else {
            timer!.invalidate()
            timer = nil
            timerLabel.text = String(weaponRespawnTime)
            sender.setTitle("Start", for: .normal)
            backgroundImageView.backgroundColor = UIColor.purple
        }
    }
    
    @objc func update() {
        if timeRemaining >= 0 {
            timerLabel.text = convertToString(from:timeRemaining)
            timeRemaining -= 1
            if timeRemaining == 0 {
                timerBackgroundView.tintColor = UIColor.green
            }
        }
        
       
    }
    
    func convertToString(from number : Int) -> String {
        if (number % 3600) % 60 < 10 {
            return "\((number % 3600) / 60):0\((number % 3600) % 60)"
        } else {
            return "\((number % 3600) / 60):\((number % 3600) % 60)"
        }
    }
    

}

extension TImerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weaponArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weaponCell", for: indexPath) as? WeaponCell {
            cell.configCell(weaponArray[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let image = UIImage(named: weaponArray[indexPath.row].name!) {
            pictureVIew.image = image
        }
    }
    
    
}
