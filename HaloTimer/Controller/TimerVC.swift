//
//  TImerVC.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/13/21.
//

import UIKit
import CoreData
import AVFoundation


class TimerVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var weaponTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var timerBackgroundView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var infoButton: UIBarButtonItem!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var audioPlayer: AVAudioPlayer?
    var selectedMap: Map?
    var weaponArray = [Weapon]()
    var timer: Timer?
    var weaponRespawnTime = 0
    var timeRemaining = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 10
        setAllUILayers()
        setCustomFontForTitle()
        loadWeaponsFromSelectedMap()
        setFirstWeapon()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? DirtySpawnVC,
           let imageName = selectedMap?.imageName {
            destVC.mapImageName = imageName
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    //MARK: - IBActions
    @IBAction func infoButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "dirtySpawnSegue", sender: nil)
    }
    
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        if sender.currentTitle == "Start" {
            timeRemaining = weaponRespawnTime
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            timer!.fire()
            sender.setTitle("Stop", for: .normal)
        } else {
            sender.setTitle("Start", for: .normal)
            timer!.invalidate()
            timer = nil
            timerLabel.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.3098039216, blue: 0.2549019608, alpha: 0.7487356022)
        }
    }
}

//MARK: - Collection view data source and delegate methods
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
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.alpha = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                cell.alpha = 1.0
            }
            let weapon = weaponArray[indexPath.row]
            weaponTitle.text = weapon.name
        }
        
        if let respawnTime = weaponArray[indexPath.row].respawnTime {
            timerLabel.text = convertToMinutesAndSeconds(from: respawnTime)
            weaponRespawnTime = Int(respawnTime) ?? Int()
            startButton.setTitle("Start", for: .normal)
            if timer != nil {
                timer!.invalidate()
                timer = nil
            }
            timerLabel.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.3098039216, blue: 0.2549019608, alpha: 0.7487356022)
        }
    }
    
}

//MARK: - Helper Functions
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

extension TimerVC {
    
    func setFirstWeapon() {
        if let firstWeapon = weaponArray.first,
           let respawnTime = firstWeapon.respawnTime,
           let integerRespawnTime = Int(respawnTime) {
            weaponTitle.text = firstWeapon.name
            timerLabel.text = convertToMinutesAndSeconds(from: respawnTime)
            weaponRespawnTime = integerRespawnTime
            timeRemaining = integerRespawnTime
        }
        
    }
    
    func setAllUILayers() {
        timerBackgroundView.layer.shadowColor = UIColor.black.cgColor
        timerBackgroundView.layer.shadowRadius = 5
        timerBackgroundView.layer.shadowOpacity = 0.5
        timerBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 20)
        timerBackgroundView.backgroundColor = #colorLiteral(red: 0.3568627451, green: 0.5411764706, blue: 0.4470588235, alpha: 0.5963264718)
        timerBackgroundView.layer.cornerRadius = 10
        
        startButton.layer.cornerRadius = 10
        startButton.backgroundColor = #colorLiteral(red: 0.3568627451, green: 0.5411764706, blue: 0.4470588235, alpha: 1)
        startButton.layer.borderWidth = 3
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.shadowColor = UIColor.black.cgColor
        startButton.layer.shadowRadius = 5
        startButton.layer.shadowOpacity = 1
        
        timerLabel.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.3098039216, blue: 0.2549019608, alpha: 0.7487356022)
        timerLabel.layer.shadowColor = UIColor.black.cgColor
        timerLabel.layer.shadowOpacity = 1
        timerLabel.layer.shadowRadius = 5
        timerLabel.layer.shadowOffset = CGSize(width: 0, height: 20)
        timerLabel.layer.cornerRadius = 10
        timerLabel.layer.borderWidth = 3
        timerLabel.layer.borderColor = UIColor.white.cgColor
        
        backgroundImageView.layer.cornerRadius = 10
    }
    
    func setCustomFontForTitle() {
        if let titleName = selectedMap?.mapName {
            navigationItem.title = titleName
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "MyriadPro-Regular", size: 35) as Any]
        }
        
    }
    
    @objc func update() {
        DispatchQueue.main.async {
            if self.timeRemaining >= 0 {
                self.timerLabel.text = self.convertToMinutesAndSeconds(from: String(self.timeRemaining))
                self.timeRemaining -= 1
                if self.timeRemaining == 29 {
                    let url = URL(fileURLWithPath: Constants.audioPath1!)
                    do {
                        self.audioPlayer = try AVAudioPlayer(contentsOf:url )
                        self.audioPlayer?.play()
                    } catch {
                        debugPrint(error)
                    }
                }
                if self.timeRemaining == -1 {
                    self.timerLabel.backgroundColor = UIColor.green
                }
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
