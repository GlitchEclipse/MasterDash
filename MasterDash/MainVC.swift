//
//  MainVC.swift
//  MasterDash
//
//  Created by Patrick Polomsky on 4/6/17.
//  Copyright © 2017 Patrick Polomsky. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var welcomeLbl: UILabel!
    
    var profile: UserProfile!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            self.updateUI()

    }
    
    func updateUI() {
        
        welcomeLbl.text = UserProfile.instance.firstName
        print("This code will be called")
        
    }
    
    
  


}
