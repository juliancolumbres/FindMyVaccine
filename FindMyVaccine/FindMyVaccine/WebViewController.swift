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
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self // WebViewController class will be delegate of webview
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // show website
        let url = URL(string: "https://www.google.com")!
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
