//
//  ViewController.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 20.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import UIKit
import CoreData

class EmailedController: NewsClass {
	
	@IBOutlet weak var newsTableView: UITableView!
	
	let currentNewsType = "emailed"
	var context: NSManagedObjectContext?
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		getActualNews(newsTableView: newsTableView, newsType: currentNewsType)
	}
	
}

