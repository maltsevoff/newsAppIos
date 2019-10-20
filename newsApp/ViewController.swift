//
//  ViewController.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 20.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

//	@IBAction func emailedButton(_ sender: UIButton) {
//		currentNewsType = "emailed"
//	}
//	@IBAction func sharedButton(_ sender: UIButton) {
//		currentNewsType = "shared"
//	}
//	@IBAction func viewedButton(_ sender: UIButton) {
//		currentNewsType = "viewed"
//	}
	
	@IBOutlet weak var newsTableView: UITableView!
	
	let requestManager = RequestManager()
	var currentNewsType = "emailed" {
		didSet {
			if oldValue != currentNewsType {
				getActualNews()
			}
		}
	}
	var selectedCell: Int?
	var context: NSManagedObjectContext?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.title = "News"
		getActualNews()
	}
	
	func getActualNews() {
		print("news: \(currentNewsType)")
		requestManager.getNews(newsType: currentNewsType) { titles in
			articles = titles
			DispatchQueue.main.async {
				if articles.isEmpty {
					self.alertManager()
				} else {
					self.newsTableView.reloadData()
				}
			}
		}
	}
	
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		if segue.identifier == "ShowArticleDetails" {
//			let destination = segue.destination as! ArticleController
//			destination.articleNumber = selectedCell
//		}
//	}
	
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
//		performSegue(withIdentifier: "ShowArticleDetails", sender: nil)
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
//	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//		let contextAction = UIContextualAction(style: .normal, title: "Favourite") { (contextualAction, view, boolValue) in
//
//		}
//		let swipeAction = UISwipeActionsConfiguration(actions: <#T##[UIContextualAction]#>)
//	}

}

