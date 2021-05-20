//
//  WeaponCell.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/13/21.
//

import UIKit

class WeaponCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weaponLabel: UILabel!
    
    func configCell(_ weapon: Weapon) {
        weaponLabel.text = weapon.name!
        imageView.image = UIImage(named: "\(weapon.name!)")
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7960784314, blue: 0.6588235294, alpha: 0.85)
        
        
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 3
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: -2, height: 5)
    }
    
    
}
