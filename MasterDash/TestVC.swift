//
//  MainVC.swift
//  MasterDash
//
//  Created by Patrick Polomsky on 4/6/17.
//  Copyright © 2017 Patrick Polomsky. All rights reserved.
//

import UIKit

class TestVC: UIViewController {
    
    
    var oauth: Auth!
    
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        requestToken()
    
    }

  
    func requestToken() {
        let request = NSURLRequest(url: URL(string: "https://openapi.etsy.com/v2/oauth/request_token?scope=transactions_r")!)
        print(request)
    }


}
