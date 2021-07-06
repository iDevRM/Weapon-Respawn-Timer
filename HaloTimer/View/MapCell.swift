//
//  MapCell.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/11/21.
//

import UIKit

class MapCell: UITableViewCell {

    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var nameLabel:    UILabel!
    
    
    
    func configCell(with map: Map) {
        if let name  = map.mapName,
           let image = map.imageName {
            mapImageView.image = UIImage(named: image)!
            nameLabel.text     = name
        }
        nameLabel.layer.shadowColor   = UIColor.black.cgColor
        nameLabel.layer.shadowRadius  = 3
        nameLabel.layer.shadowOpacity = 2
        nameLabel.layer.shadowOffset  = CGSize(width: 2, height: 2)
        
    }

}
