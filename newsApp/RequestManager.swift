//
//  RequestManager.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 20.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RequestManager {
	
	private let apiKey = "ljGvO44YKHpS4hUn3GG2I5nNH6NscttG"
	private let period = 30
	
	func getNews(newsType: String, completionHandler: @escaping([News]) -> Void) {
		let reqUrl = "https://api.nytimes.com/svc/mostpopular/v2/\(newsType)/\(period).json?api-key=\(apiKey)"
		request(reqUrl).responseJSON(completionHandler: { response in
			if response.result.isSuccess {
				let dict = JSON(response.value!)
				let titles = self.parseData(data: dict)
				completionHandler(titles)
			} else {
				completionHandler([])
			}
			})
	}
	
	private func parseData(data: JSON) -> [News] {
		guard let array = data["results"].array else { return []}
		var resArray: [News] = []
		for element in array {
			guard let title = element["title"].string else { continue }
			let imageUrlData = element["media"].arrayValue.map { $0["media-metadata"][0]["url"].string }
			let imageUrl = imageUrlData[0] ?? ""
			let published = element["published_date"].string ?? "no date"
			let source = element["source"].string ?? "no source"
			let arrayNode = News(title: title, imageUrl: imageUrl, publishedDate: published, source: source, articleData: element)
			resArray.append(arrayNode)
		}
		return resArray
	}
}
