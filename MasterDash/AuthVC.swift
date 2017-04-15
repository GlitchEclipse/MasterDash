//
//  AuthVC.swift
//  MasterDash
//
//  Created by Patrick Polomsky on 4/6/17.
//  Copyright © 2017 Patrick Polomsky. All rights reserved.
//

import UIKit
import OAuthSwift

class AuthVC: OAuthViewController {

    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var usernameTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    //Base Setup
    
   
    let profile = UserProfile.instance
    
    
    lazy var internalWebView: WebViewController = {
        let controller = WebViewController()
        controller.view = UIView(frame: UIScreen.main.bounds)
        controller.delegate = self
        controller.viewDidLoad()
        return controller
    }()
    


   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        usernameTxtFld.text = "glitcheclipse"
        passwordTxtFld.text = "glitch08"
        
        
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MainVC" {
            
            if let loginDetails = segue.destination as? MainVC {
                
                if let profile = sender as? UserProfile {
                    
                    loginDetails.profile = profile
                }
            }
        }
        
    }
    
    
    func openWebView() -> OAuthSwiftURLHandlerType {
        return internalWebView
    }
 
    @IBAction func loginBtn(_ sender: Any) {
         
        
       
        self.openWebView()
        UserProfile.instance.oauthSwift.authorizeURLHandler = WebViewController()
        
            
            if usernameTxtFld.text == "glitcheclipse" && passwordTxtFld.text == "glitch08" {
               
                profile.doEtsyAuth({self.oauthWebViewControllerDidDismiss()})
//                profile.doEtsyAuth({ self.moveToMainVC() })
               
                
                
            } else {
                let alert = UIAlertController(title: "Password Invalid", message: "You typed in the wrong shit!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    func moveToMainVC() {
        
        performSegue(withIdentifier: "MainVC", sender: nil)
    }
    
   
}

extension AuthVC: OAuthWebViewControllerDelegate {
    func oauthWebViewControllerDidPresent() {
        
    }
    
    func oauthWebViewControllerDidDismiss() {
        internalWebView.dismissWebViewController()
        self.moveToMainVC()
    }
    
    func oauthWebViewControllerDidAppear() {
        
    }
    
    func oauthWebViewControllerWillAppear() {
        
    }

    func oauthWebViewControllerDidDisappear() {
        UserProfile.instance.oauthSwift.cancel()
    }
    
    func oauthWebViewControllerWillDisappear() {
        
    }
}


