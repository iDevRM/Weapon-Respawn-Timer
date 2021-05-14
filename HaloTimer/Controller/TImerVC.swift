//
//  TImerVC.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/13/21.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let map = selectedMap {
            timerLabel.text = map.mapName!
            startButton.layer.cornerRadius = 10
            startButton.backgroundColor = #colorLiteral(red: 0.5081628561, green: 0.7110635638, blue: 0.4669082761, alpha: 1)
            backgroundView.backgroundColor = #colorLiteral(red: 0.3257828355, green: 0.5983628631, blue: 0.7235913277, alpha: 1)
            pictureBackroundView.layer.cornerRadius = 10
            backgroundImageView.layer.cornerRadius = 10
            collectionView.layer.cornerRadius = 10
            
        }
    }
    
    @IBAction func infoButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
    }
    

}

extension TImerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
