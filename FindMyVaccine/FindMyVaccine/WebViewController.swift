//
//  WebViewController.swift
//  FindMyVaccine
//
//  Created by Melanie Chan on 4/28/21.
//

import UIKit
import WebKit

// screen to visit external website using webview
class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var websiteUrl: String!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self // WebViewController class will be delegate of webview
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // show website
        
        if (websiteUrl == "https://www.healthmartcovidvaccine.com/") {
            websiteUrl = "https://scrcxp.pdhi.com/Portal/Member/d1e1f5d5-007f-4167-b8d1-1ea83cb3b215/?qitq=1fcaf2ae-6f5f-47d1-b2b8-e1d623c6abbb&qitp=54b92d39-9390-4dc4-a9ff-9d9c07936279&qitts=1619821094&qitc=pdhi&qite=covid19vaccination&qitrt=Safetynet&qith=edf6d13e2ec89f9052bb1a18eff5c681"
        }
        
        print(websiteUrl)
        let url = URL(string: websiteUrl)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
