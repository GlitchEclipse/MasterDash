//
//  SignInVCViewController.swift
//  MasterDash
//
//  Created by Patrick Polomsky on 4/6/17.
//  Copyright © 2017 Patrick Polomsky. All rights reserved.
//

import UIKit
import OAuthSwift
import Alamofire

class AuthVC: UIViewController {
    
    var oauthSwift: OAuth1Swift!
   
    var authToken: String?
    var authSecretToken: String?
    var accessToken: String?
    
    @IBOutlet weak var webview: UIWebView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doEtsyAuth()
        testEtsy(oauthSwift)
        //getRequestToken()
        
    }
    
//    func getRequestToken() {
//        Alamofire.request("https://openapi.etsy.com/v2/oauth/request_token?scope=email_r%20listings_r").responseJSON { response in
//            print(response.request as Any)
//            print(response.response as Any)
//            print(response.data as Any)
//            print(response.result)
//        }
//    }
//    
    
    
    func doEtsyAuth() {
        
        let oauthSwift = OAuth1Swift(
            consumerKey: "otg6z6cu1kcrq4bdhxcexs1p",
            consumerSecret: "x6k93pqvhm",
            requestTokenUrl: "https://openapi.etsy.com/v2/oauth/request_token?scope=email_r%20listings_r",
            authorizeUrl: "http://www.etsy.com/oauth/signin?oauth_token=7aea9c743a9aee7d17fbe57b64a2ee&oauth_consumer_key=otg6z6cu1kcrq4bdhxcexs1p",
            accessTokenUrl: "https://openapi.etsy.com/v2/oauth/access_token?scope=transactions_r"
            )
    
        
        self.oauthSwift = oauthSwift
        print("\(self.oauthSwift)")
        
//        oauthSwift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthSwift)

        
//            print("\(oauthSwift.parameters)")
    
        let _ = oauthSwift.authorize(
            withCallbackURL: URL(string: "MasterDash://oauth-callback/etsy")!,
            success: { credential, response, parameters in
                print("Success")
                print("OAuth Token = \(credential.oauthToken)")
                print("OAuth Token Secret = \(credential.oauthTokenSecret)")
                print("OAuth Verify Code = \(credential.oauthVerifier)")
                
                
                print(response.debugDescription)
                
        },
            failure: { error in
                print(error.localizedDescription)
        }
    )
    }
    
    func testEtsy( _ oauthSwift: OAuth1Swift) {
        let _ = oauthSwift.client.get( "\(URL_BASE)/users/glitcheclipse/transactions",
            success: { response in
                let dataString = response.string
                print(dataString!)
                print(response)
                print("I was allowed access!")
        },
            failure: { error in
                print(error)
        }
        )
    }

    

        
//    func handleWebView() {
//        
//        let salesURL = URL(string: "https://openapi.etsy.com/v2/oauth/request_token?scope=transactions_r")!
//        
//        let request = URLRequest(url: salesURL)
//        self.webview.loadRequest(request)
//    }
    
 
  
    
}
