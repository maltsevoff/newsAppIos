//
//  Model.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 20.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

struct News {
	var title: String
	var imageUrl: String
	var publishedDate: String
	var source: String
	var uri: String
	var url: String
	var articleData: JSON
}

var articles: [News] = []
var favouriteArticles: [Article] = []
var selectedCell: Int?
var context: NSManagedObjectContext?

func imagesForArticle(index: Int) -> [String] {
	var images: [String] = []
	if index >= articles.count { return images }
	let article = articles[index].articleData
	let articleImages = article["media"].arrayValue.map { $0["media-metadata"] }
	for imgInfo in articleImages[0] {
		let imgUrl = imgInfo.1["url"].stringValue
		images.append(imgUrl)
	}
	return images
}

func saveFavourites(article: News) {
	print("article uri:", article.uri)
	if favouriteArticles.contains(where: {$0.uri == article.uri}) {
		return
	}
	let entity = NSEntityDescription.entity(forEntityName: "Article", in: context!)
	let articleObject = NSManagedObject(entity: entity!, insertInto: context) as! Article
	articleObject.url = article.url
	articleObject.title = article.title
	articleObject.image = article.imageUrl
	articleObject.publishDate = article.publishedDate
	articleObject.source = article.source
	articleObject.uri = article.uri
	do {
		try context?.save()
		favouriteArticles.append(articleObject)
	} catch {
		print(error.localizedDescription)
	}
}

func getFavouriteArticles() -> [Article] {
	let request: NSFetchRequest<Article> = Article.fetchRequest()
	do {
		let favArticles: [Article] = try (context?.fetch(request))!
		return favArticles
	} catch {
		print(error.localizedDescription)
		return []
	}
}
