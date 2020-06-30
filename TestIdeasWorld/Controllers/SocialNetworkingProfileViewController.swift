//
//  SocialNetworkingProfileViewController.swift
//  TestIdeasWorld
//
//  Created by Alina on 2020-06-29.
//  Copyright © 2020 Alina. All rights reserved.
//

import UIKit
import WebKit

class SocialNetworkingProfileViewController: UIViewController, WKUIDelegate {
    
    var currentURLString: String = ""
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let myURL = URL(string: currentURLString) else { return }
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
}


