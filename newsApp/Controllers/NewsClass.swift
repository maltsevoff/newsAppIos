//
//  NewsClass.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 21.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import UIKit

class NewsClass: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
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
	
	// MARK: - Table View
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return articles.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
		let newsNode = articles[indexPath.row]
		cell.articleTitle = newsNode.title
		cell.articleImageUrl = newsNode.imageUrl
		cell.articleDate = newsNode.publishedDate
		cell.newsSource = newsNode.source
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(indexPath.row)
		selectedCell = indexPath.row
		performSegue(withIdentifier: "ShowArticleDetails", sender: nil)
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let contextAction = UIContextualAction(style: .normal, title: "Favourite") { (contextualAction, view, complete) in
			print("pressed action favourite")
			saveFavourites(article: articles[indexPath.row])
			complete(true)
		}
		let swipeAction = UISwipeActionsConfiguration(actions: [contextAction])
		return swipeAction
	}
}
