//
//  TImerVC.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/13/21.
//

import UIKit
import CoreData
import Foundation

class TimerVC: UIViewController, UINavigationControllerDelegate {

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
        timerBackgroundView.backgroundColor = #colorLiteral(red: 0.3568627451, green: 0.5411764706, blue: 0.4470588235, alpha: 0.558723763)
        timerLabel.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.3098039216, blue: 0.2549019608, alpha: 0.7487356022)
        startButton.backgroundColor = #colorLiteral(red: 0.3568627451, green: 0.5411764706, blue: 0.4470588235, alpha: 0.558723763)
        pictureBackroundView.layer.cornerRadius = 10
        backgroundImageView.layer.cornerRadius = 10
        collectionView.layer.cornerRadius = 10
        timerBackgroundView.layer.cornerRadius = 10
        timerLabel.layer.cornerRadius = 10
        pictureBackroundView.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7960784314, blue: 0.6588235294, alpha: 0.85)
        infoButton.tintColor = UIColor.white
        timerBackgroundView.layer.shadowColor = UIColor.black.cgColor
        timerBackgroundView.layer.shadowRadius = 5
        timerBackgroundView.layer.shadowOpacity = 1
        timerBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 20)
        pictureBackroundView.layer.borderWidth = 3
        pictureBackroundView.layer.borderColor = UIColor.white.cgColor
        
        timerLabel.layer.borderWidth = 3
        timerLabel.layer.borderColor = UIColor.white.cgColor
        startButton.layer.borderWidth = 3
        startButton.layer.borderColor = UIColor.white.cgColor
        
    
        pictureBackroundView.layer.shadowColor = UIColor.black.cgColor
        pictureBackroundView.layer.shadowRadius = 5
        pictureBackroundView.layer.shadowOpacity = 1
        startButton.layer.shadowColor = UIColor.black.cgColor
        startButton.layer.shadowRadius = 5
        startButton.layer.shadowOpacity = 1
        pictureVIew.layer.shadowOpacity = 1
        pictureVIew.layer.shadowRadius = 5
        pictureVIew.layer.shadowColor = UIColor.black.cgColor
        pictureVIew.layer.shadowOffset = CGSize(width: -2, height: 5)
        navigationController?.delegate = self
        if let titleName = selectedMap?.mapName {
            navigationItem.title = titleName
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "MyriadPro-Regular", size: 35)]
           
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? DirtySpawnVC {
            destVC.mapImageName = selectedMap!.imageName!
        }
    }
    
    @IBAction func infoButtonTapped(_ sender: UIBarButtonItem) {
       
        performSegue(withIdentifier: "dirtySpawnSegue", sender: nil)
       
        
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        if sender.currentTitle == "Start" {
            sender.setTitle("Stop", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            timer!.fire()
            timeRemaining = weaponRespawnTime
        } else {
            sender.setTitle("Start", for: .normal)
            timer!.invalidate()
            timer = nil
            timerLabel.text = convertToMinutesAndSeconds(from: String(timeRemaining))
            backgroundImageView.backgroundColor = UIColor.purple
        }
    }
    
    @objc func update() {
        if timeRemaining > 0 {
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

extension TimerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
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

extension TimerVC {
    
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
