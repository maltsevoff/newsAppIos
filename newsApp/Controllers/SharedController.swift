//
//  EmailedController.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 20.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import UIKit
import CoreData

class SharedController: NewsClass {
	
	@IBOutlet weak var newsTableView: UITableView!
	
	let currentNewsType = "shared"
	var context: NSManagedObjectContext?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.title = "News"
		getActualNews(newsTableView: newsTableView, newsType: currentNewsType)
	}
}
