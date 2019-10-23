//
//  FavouriteController.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 22.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.

import UIKit
import CoreData

class FavouriteController: UIViewController, UITableViewDelegate, UITableViewDataSource{
	
	@IBOutlet weak var favouriteTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		favouriteArticles = getFavouriteArticles()
		print(favouriteArticles)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		favouriteTableView.reloadData()
		print("appear", favouriteArticles)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print("counted", favouriteArticles.count)
		return favouriteArticles.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! NewsCell
		let cellNode = favouriteArticles[indexPath.row]
		cell.articleTitle = cellNode.title
		cell.articleImageUrl = cellNode.image
		cell.articleDate = cellNode.publishDate
		cell.newsSource = cellNode.source
		return cell
	}
	
	func deleteData() {
		let request: NSFetchRequest<Article> = Article.fetchRequest()
		do {
			let people: [Article] = try (context?.fetch(request))!
			
			for person in people {
				context?.delete(person)
			}
			try context?.save()
		} catch {
			print(error.localizedDescription)
		}
	}
	
}
