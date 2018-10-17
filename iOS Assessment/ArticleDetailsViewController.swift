//
//  ArticleDetailsViewController.swift
//  iOS Assessment
//
//  Created by Kundan Jadhav on 17/10/18.
//  Copyright © 2018 Quick Heal Technologies Ltd. All rights reserved.
//

import UIKit
import WebKit

class ArticleDetailsViewController: UIViewController, WKNavigationDelegate {

    var url : String?
    @IBOutlet weak var webView: WKWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let validUrl = url {
            if Reachability.isConnectedToNetwork(){
            self.webView.load(URLRequest.init(url: URL.init(string: validUrl)!))
            }else{
                Utils.showResponseError(viewController: self, error: "Internet connection not available")

            }
        }
        // Do any additional setup after loading the view.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
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
