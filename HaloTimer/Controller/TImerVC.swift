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
    
    var timer: Timer?
    
    var weaponRespawnTime = 0
    var timeRemaining     = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadWeaponsFromSelectedMap()
        
        if let firstWeapon = weaponArray.first {
            pictureVIew.image = UIImage(named: firstWeapon.name!)
            timerLabel.text = convertToMinutesAndSeconds(from: firstWeapon.respawnTime!)
            weaponRespawnTime = Int(firstWeapon.respawnTime!)!
        }
       
        startButton.layer.cornerRadius = 10
        timerBackgroundView.backgroundColor = #colorLiteral(red: 0.3568627451, green: 0.5411764706, blue: 0.4470588235, alpha: 0.85)
        timerLabel.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.3098039216, blue: 0.2549019608, alpha: 0.7487356022)
        startButton.backgroundColor = #colorLiteral(red: 0.337254902, green: 0.4666666667, blue: 0.4235294118, alpha: 0.85)
        pictureBackroundView.layer.cornerRadius = 10
        backgroundImageView.layer.cornerRadius = 10
        collectionView.layer.cornerRadius = 10
        timerBackgroundView.layer.cornerRadius = 10
        timerLabel.layer.cornerRadius = 10
        
        pictureBackroundView.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7960784314, blue: 0.6588235294, alpha: 0.85)
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
            timerLabel.text = convertToMinutesAndSeconds(from: String(timeRemaining))
            timeRemaining -= 1
            if timeRemaining == 0 {
                timerBackgroundView.tintColor = UIColor.green
            }
        }
    }
    
    func convertToMinutesAndSeconds(from number : String) -> String {
        guard let convertedNumber = Int(number) else { return "Error in converting string" }
        
        if (convertedNumber % 3600) % 60 < 10 {
            return "\((convertedNumber % 3600) / 60):0\((convertedNumber % 3600) % 60)"
        } else {
            return "\((convertedNumber % 3600) / 60):\((convertedNumber % 3600) % 60)"
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
        if let image = UIImage(named: weaponArray[indexPath.row].name!),
           let respawnTime = weaponArray[indexPath.row].respawnTime {
            pictureVIew.image = image
            timerLabel.text = convertToMinutesAndSeconds(from: respawnTime)
            weaponRespawnTime = Int(respawnTime)!
        }
    }
    
    
    
}

extension TImerVC {
    
    func loadWeaponsFromSelectedMap() {
        if let weapons = selectedMap?.weapons?.allObjects as? [Weapon] {
            for weapon in weapons {
                if weapon.respawnTime != nil {
                    weaponArray.append(weapon)
                }
            }
        }
    }
    
}
