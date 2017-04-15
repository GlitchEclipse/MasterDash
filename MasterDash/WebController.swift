//
//  WebController.swift
//  MasterDash
//
//  Created by Patrick Polomsky on 4/14/17.
//  Copyright © 2017 Patrick Polomsky. All rights reserved.
//

import OAuthSwift
import UIKit

typealias Webview = UIWebView

class WebViewController: OAuthWebViewController {
    
    var targetURL: URL?
    let webview: Webview = Webview()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webview.frame = UIScreen.main.bounds
        self.webview.scalesPageToFit = true
        self.webview.delegate = self
        self.view.addSubview(self.webview)
        loadAddressURL()

    }
    
    override func handle(_ url: URL) {
        targetURL = url
        super.handle(url)
        self.loadAddressURL()
    }
    
    func loadAddressURL() {
        guard let url = targetURL else {
            return
        }
        let request = URLRequest(url: url)
        self.webview.loadRequest(request)
    }
}

    extension WebViewController: UIWebViewDelegate {
        
        func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
            if let url = request.url, url.scheme == "oauth-swift" {
                self.dismissWebViewController()
            }
            return true
        }
    }
    
        
        
        
        
        
        
        
        
        
        

    

