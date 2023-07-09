//
//  WeaponCell.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/13/21.
//

import UIKit

class WeaponCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView:   UIImageView!
    @IBOutlet weak var weaponLabel: UILabel!
    
    func configCell(_ weapon: Weapon) {
        if let weaponName = weapon.name {
            weaponLabel.text = weaponName
            imageView.image = UIImage(named: "\(weaponName)")
        }
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7960784314, blue: 0.6588235294, alpha: 1)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 3
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: -2, height: 5)
    }
    
    
}
