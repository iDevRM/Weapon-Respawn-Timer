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
        weaponLabel.text = weapon.name
        imageView.image = UIImage(named: "\(weapon.name!)")
    }
    
    
}
