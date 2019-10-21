//
//  NewsCell.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 20.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

	@IBOutlet weak private var articleImageView: UIImageView!
	@IBOutlet weak private var titleLabel: UILabel!
	@IBOutlet weak private var dateLabel: UILabel!
	@IBOutlet weak private var newsSourceLabel: UILabel!
	
	var articleImageUrl: String? {
		didSet {
			let queue = DispatchQueue.global(qos: .background)
			queue.async {
				do {
					if let validUrl = self.articleImageUrl {
						let url = URL(string: validUrl)
						let data = try Data(contentsOf: url!)
						let img = UIImage(data: data)
						DispatchQueue.main.async {
							self.articleImageView.image = img
						}
					}
				} catch {
					
				}
			}
		}
	}
	var articleTitle: String? {
		didSet {
			titleLabel.text = articleTitle
		}
	}
	var articleDate: String? {
		didSet {
			dateLabel.text = articleDate
		}
	}
	var newsSource: String? {
		didSet {
			newsSourceLabel.text = newsSource
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

