//
//  Model.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 20.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import UIKit
import SwiftyJSON

struct News {
	var title: String
	var imageUrl: String
	var publishedDate: String
	var source: String
	var articleData: JSON
}

var articles: [News] = []

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
