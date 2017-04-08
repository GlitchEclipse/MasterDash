//
//  EtsySalesData.swift
//  MasterDash
//
//  Created by Patrick Polomsky on 4/6/17.
//  Copyright © 2017 Patrick Polomsky. All rights reserved.
//

import Foundation



class Auth {
    
    private var _consumerKey: String = "otg6z6cu1kcrq4bdhxcexs1p"
    private var _consumerSecret: String = "x6k93pqvhm"
    
    
    
    var consumerKey: String {
        return _consumerKey
    }
    
    var consumerSecret: String {
        return _consumerSecret
    }
    
    init(key: String, secret: String) {
        self._consumerKey = key
        self._consumerSecret = secret
    }
}
