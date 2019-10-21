//
//  ArticleController.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 21.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import UIKit

class ArticleController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var articleDateLabel: UILabel!
	@IBOutlet weak var articleTitleLabel: UILabel!
	@IBOutlet weak var imagesTableView: UITableView!
	
	var articleNumber: Int?
	var images: [String] = []
	var thisArticle: News?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if articleNumber != nil {
			self.images = imagesForArticle(index: articleNumber!)
			print(images)
			self.thisArticle = articles[articleNumber!]
			setInfo()
		}
	}
	
	func setInfo() {
		articleDateLabel.text = self.thisArticle?.publishedDate
		articleTitleLabel.text = self.thisArticle?.title
		articleTitleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
	}
	
	//MARK: - Table View
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return images.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
		
		cell.imageUrl = images[indexPath.row]
		return cell
	}
	
}
