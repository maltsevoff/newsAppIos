//
//  ViewedController.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 20.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import UIKit
import CoreData

class ViewedController: NewsClass, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var newsTableView: UITableView!

	let currentNewsType = "viewed"
	var context: NSManagedObjectContext?

	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.title = "News"
		getActualNews(newsTableView: newsTableView, newsType: currentNewsType)
	}

	// MARK: - Table View

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return articles.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ViewedCell", for: indexPath) as! NewsCell
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
		performSegue(withIdentifier: "ShowCellDetails", sender: nil)
	}

	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}

		func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
			let contextAction = UIContextualAction(style: .normal, title: "Favourite") { (contextualAction, view, boolValue) in
				let favouriteCell = articles[indexPath.row]
				favouriteArticles.append(favouriteCell)
				print("pressed action favourite", favouriteArticles)
			}
			let swipeAction = UISwipeActionsConfiguration(actions: [contextAction])
			return swipeAction
		}
	}
