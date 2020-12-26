//
//  ViewController.swift
//  SimpleWebBrowser
//
//  Created by shubham Garg on 17/07/20.
//  Copyright © 2020 shubham Garg. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var webview: WKWebView!
    var myActivityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        myActivityIndicator = UIActivityIndicatorView(frame: webview.frame)
        webview.navigationDelegate = self
        myActivityIndicator.center = self.view.center
        myActivityIndicator.style = UIActivityIndicatorView.Style.medium
               view.addSubview(myActivityIndicator)
               myActivityIndicator.isHidden = true

        
    }

    @IBAction func searchBtnAxn(_ sender: Any) {
        func searchTextOnGoogle(text: String){
            let textComponent = text.components(separatedBy: " ")
            let searchString = textComponent.joined(separator: "+")
            let url = URL(string: "https://www.google.com/search?q=" + searchString)
            let urlRequest = URLRequest(url: url!)
            webview.load(urlRequest)
            myActivityIndicator.isHidden = false
        }
        if let urlString = searchBar.text{
            if (urlString.starts(with: "http://") || urlString.starts(with: "https://")), let url = URL(string: (urlString)){
                let urlRequest = URLRequest(url: url)
                 webview.load(urlRequest)
                myActivityIndicator.isHidden = false
            }else if urlString.contains("www"), let url = URL(string: "http://\(urlString)"){
                let urlRequest = URLRequest(url: url)
                webview.load(urlRequest)
                myActivityIndicator.isHidden = false
            }else{
                searchTextOnGoogle(text: urlString)
            }
        }
    }
    
    @IBAction func backBtnAxn(_ sender: Any) {
        webview.goBack()
    }
    @IBAction func forwardBtnAxn(_ sender: Any) {
        webview.goForward()
    }
}

extension ViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.isHidden = true
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.isHidden = true
    }
}
