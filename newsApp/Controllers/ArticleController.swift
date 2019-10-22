//
//  ArticleController.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 22.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import UIKit
import WebKit

class ArticleController: UIViewController, WKUIDelegate {
	
	var webView: WKWebView!
	var newsUrl: URL?
	
	override func loadView() {
		let webConfiguration = WKWebViewConfiguration()
		webView = WKWebView(frame: .zero, configuration: webConfiguration)
		webView.uiDelegate = self
		view = webView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let myRequest = URLRequest(url: newsUrl!)
		webView.load(myRequest)
	}
	
	func showActivityIndicator() {
		
	}
}
