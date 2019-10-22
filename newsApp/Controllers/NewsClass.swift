//
//  NewsClass.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 21.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import UIKit

class NewsClass: UIViewController {
	
	let requestManager = RequestManager()
	var selectedCell: Int?
	
	func getActualNews(newsTableView: UITableView, newsType: String) {
		print("news: \(newsType)")
		requestManager.getNews(newsType: newsType) { titles in
			articles = titles
			DispatchQueue.main.async {
				if articles.isEmpty {
					self.alertManager()
				} else {
					newsTableView.reloadData()
				}
			}
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ShowArticleDetails" {
			let destination = segue.destination as! ArticleController
			destination.newsUrl = URL(string: articles[selectedCell!].url)
		}
	}
	
	func alertManager() {
		let message = "Some problems with internet connection. Try again later."
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true)
	}
}
