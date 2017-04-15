//
//  UserProfile.swift
//  MasterDash
//
//  Created by Patrick Polomsky on 4/8/17.
//  Copyright © 2017 Patrick Polomsky. All rights reserved.
//

import Foundation
import OAuthSwift

class UserProfile   {
    
    //Create a global instance of everything in this class for the app
    static let instance = UserProfile()
    
    private var _loginName: String!
    private var _firstName: String!
    private var _lastName: String!
    private var _joinDate: Int!
    private var _region: String!
    private var _city: String!
    private var _country: Int!
    private var _userProfileURL: String!
    private var _userImg: UIImage!

    
    var loginName: String {
        if _loginName == nil {
            _loginName = ""
        }
        return _loginName
    }
    
    var firstName: String {
        if _firstName == nil {
            _firstName = ""
        }
        return _firstName
    }
    
    var lastName: String {
        if _lastName == nil {
            _lastName = ""
        }
        return _lastName
    }
    
    var joinDate: Date {
        let date = NSDate(timeIntervalSince1970: Double(_joinDate))
        return date as Date
    }
    
    var region: String {
        if _region == nil {
            _region = ""
        }
        return _region
    }
    
    var city: String {
        if _city == nil {
            _city = ""
        }
        return _city
    }
    
    var country: String {
        return "United States"
    }
    
    let oauthSwift = OAuth1Swift(
        consumerKey: "\(CONSUMER_KEY)",
        consumerSecret: "\(CONSUMER_SECRET)",
        requestTokenUrl: "https://openapi.etsy.com/v2/oauth/request_token",
        authorizeUrl: "https://www.etsy.com/oauth/signin",
        accessTokenUrl: "https://openapi.etsy.com/v2/oauth/access_token"
    )
    
   
    
    func doEtsyAuth(_ completed: @escaping DownloadComplete) {
        
        let _ = oauthSwift.authorize(
            withCallbackURL: URL(string: "MasterDash://oauth-callback/etsy")!,
            success: { credential, response, parameters in
                self.getEtsyAPIData({
                    completed()
                })
        },
            failure: { error in
                print(error.localizedDescription)
                
        })
    }
    
    func getEtsyAPIData(_ completed: @escaping DownloadComplete) {
        
        
        let _ = oauthSwift.client.get( "\(URL_BASE)/users/\(USER_ID)/profile",
            success: { response in
                
                do {
                    let myJson = try JSONSerialization.jsonObject(with: response.data, options: .mutableContainers)
                    if let dict = myJson as? Dictionary<String, AnyObject> {
                        print(dict)
                        if let results = dict["results"] as? [Dictionary<String, AnyObject>] {
                            let userData = results[0]
                            
                            if let loginName = userData["login_name"] as? String {
                                self._loginName = loginName
                                print(loginName)
                            }
                            
                            if let firstName = userData["first_name"] as? String {
                                self._firstName = firstName
                            }
                            
                            if let lastName = userData["last_name"] as? String {
                                self._lastName = lastName
                            }
                            
                            if let joinDate = userData["join_tsz"] as? Int {
                                self._joinDate = joinDate
                            }
                            
                            if let region = userData["region"] as? String {
                                self._region = region
                            }
                            
                            if let country = userData["country_id"] as? Int {
                                self._country = country
                            }
                            
                            if let city = userData["city"] as? String {
                                self._city = city
                            }
                            
                            completed()
                        }
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
                
                print("I was allowed access to USER'S PROFILE INFO!")
                print("\(self.loginName)")
                print("\(self.firstName)")
                print("\(self.lastName)")
                print("\(self.joinDate)")
                print("\(self.city)")
                print("\(self.region)")
                print("\(self.country)")
                
                
        },
            failure: { error in
                print(error)
                
        })
        
    }
    
 
    
  
}




