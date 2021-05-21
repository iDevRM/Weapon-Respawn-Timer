//
//  DirtySpawnVC.swift
//  HaloTimer
//
//  Created by Ricardo Martinez on 5/20/21.
//

import UIKit
import CoreData


class DirtySpawnVC: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var mapImageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.borderWidth = 5
        backgroundView.layer.borderColor = UIColor.white.cgColor
        
        
        imageView.image = UIImage(named: mapImageName)
        messageLabel.font = UIFont(name: "MyriadPro-Regular", size: 20)
        messageLabel.text = "Dirty Spawn: When picking up a weapon you must stand still for at least 1 full second to avoid dirtying it (delaying the next spawn). If you can't stand still right away, the timer starts once you stand still or once you die."
        
      
    }

    

}
