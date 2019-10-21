//
//  ImageCell.swift
//  newsApp
//
//  Created by Aleksandr Maltsev on 21.10.2019.
//  Copyright © 2019 Aleksandr Maltsev. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
	
	var imageUrl: String? {
		didSet {
			let queue = DispatchQueue.global(qos: .background)
			queue.async {
				do {
					let url = URL(string: self.imageUrl!)
					if let validUrl = url {
						let data = try Data(contentsOf: validUrl)
						let image = UIImage(data: data)
						DispatchQueue.main.async {
							self.imageView?.image = image
						}
					}
				} catch {
					print(error.localizedDescription)
				}
			}
		}
	}
	
}
