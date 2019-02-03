//
//  ArticleViewController.swift
//  wsjrss
//
//  Created by Slobodan Kovrlija on 2/2/19.
//  Copyright © 2019 Slobodan. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController {

    // MARK: - Properties
    var articleUrlString = ""
    var webView = WKWebView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWebView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
    }
    
    func setWebView() {
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(webView)
        
        // enable back and forward swiping
        webView.allowsBackForwardNavigationGestures = true
        
        if let url = URL(string: articleUrlString) {
            webView.load(URLRequest(url: url))
        }
    }

    @objc func refreshTapped() {
        webView.reload()
    }
}
