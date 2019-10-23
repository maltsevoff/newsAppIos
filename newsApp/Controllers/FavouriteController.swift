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
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ShowArticleDetails" {
			let destination = segue.destination as! ArticleController
			destination.newsUrl = URL(string: favouriteArticles[selectedCell!].url ?? "")
		}
	}
	
	//MARK: - Table View
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(indexPath.row)
		selectedCell = indexPath.row
		performSegue(withIdentifier: "ShowArticleDetails", sender: nil)
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
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard let personToDelete = favouriteArticles[indexPath.row] as? Article, editingStyle == .delete else {
			return
		}
		context?.delete(personToDelete)
		
		do {
			try context?.save()
			favouriteArticles.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		} catch let error as NSError {
			print("Error: \(error), description \(error.userInfo)")
		}
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
