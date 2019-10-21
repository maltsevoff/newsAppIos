//
//  ArticleController.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 21.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import UIKit

class ArticleController: UIViewController {
	
	@IBOutlet weak var articleDateLabel: UILabel!
	@IBOutlet weak var articleTitleLabel: UILabel!
	
	var articleNumber: Int?
	var imagesUrl: [String] = []
	var thisArticle: News?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if articleNumber != nil {
			self.imagesUrl = imagesForArticle(index: articleNumber!)
			print(imagesUrl)
			self.thisArticle = articles[articleNumber!]
			setInfo()
		}
	}
	
	func setInfo() {
		articleDateLabel.text = self.thisArticle?.publishedDate
		articleTitleLabel.text = self.thisArticle?.title
		articleTitleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
	}
}
