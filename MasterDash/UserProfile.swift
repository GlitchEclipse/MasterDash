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
        let localIdentifier = Locale.current.identifier
        let locale = NSLocale(localeIdentifier: localIdentifier)
        if let countryCode = locale.object(forKey: .countryCode) as? String {
            if let _: String = locale.displayName(forKey: .countryCode, value: countryCode) {
               
            }
        }
         return self.country
    }
    
  
    init(userID: String, firstName: String) {
        
        self._loginName = userID
        self._firstName = firstName
        
        self._userProfileURL = "\(URL_BASE)\(USER_ID)/profile"
    }
 
        
    let oauthSwift = OAuth1Swift(
        consumerKey: "\(CONSUMER_KEY)",
        consumerSecret: "\(CONSUMER_SECRET)",
        requestTokenUrl: "https://openapi.etsy.com/v2/oauth/request_token",
        authorizeUrl: "https://www.etsy.com/oauth/signin",
        accessTokenUrl: "https://openapi.etsy.com/v2/oauth/access_token"
    )
    
    


    func doEtsyAuth() {
        
        let _ = oauthSwift.authorize(
            withCallbackURL: URL(string: "MasterDash://oauth-callback/etsy")!,
            success: { credential, response, parameters in
                print("Success")
                print("OAuth Token = \(credential.oauthToken)")
                print("OAuth Token Secret = \(credential.oauthTokenSecret)")
                print("OAuth Verify Code = \(credential.oauthVerifier)")
                
                //print(response.debugDescription)
                
                self.getEtsyAPIData()
                
               

           
        },
            failure: { error in
                print(error.localizedDescription)
               
        })
    }

    func getEtsyAPIData() {
        
        let _ = oauthSwift.client.get( "\(URL_BASE)/users/\(USER_ID)/profile",
            success: { response in
                
                let jsonDict = try? response.jsonObject()
                print(jsonDict as Any)
                
                                if let dict = jsonDict as? Dictionary<String, AnyObject> {
                
                                    if let loginName = dict["user_id"] as? String {
                                        self._loginName = loginName
                                    }
                                    
                                    if let firstName = dict["first_name"] as? String {
                                        self._firstName = firstName
                                    }
                                    
                                    if let lastName = dict["last_name"] as? String {
                                        self._lastName = lastName
                                    }
                                    
                                    if let joinDate = dict["join_tsz"] as? Int {
                                        self._joinDate = joinDate
                                    }
                                    
                                    if let region = dict["region"] as? String {
                                        self._region = region
                                    }
                                    
                                    if let country = dict["country_id"] as? Int {
                                        self._country = country
                                    }
                                    
                                    if let city = dict["city"] as? String {
                                        self._city = city
                                    }
                                }
                
                print("I was allowed access to USER'S PROFILE INFO!")
                print("\(self._loginName)")
                print("\(self._firstName)")
                print("\(self._lastName)")
                print("\(self._joinDate)")
                print("\(self._city)")
                print("\(self._region)")
                print("\(self._country)")
                
                
        },
            failure: { error in
                print(error)
              
        })
        
    
        
    }
    

    
}




