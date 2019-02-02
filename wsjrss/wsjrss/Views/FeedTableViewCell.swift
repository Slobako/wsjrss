//
//  FeedTableViewCell.swift
//  wsjrss
//
//  Created by Slobodan Kovrlija on 2/1/19.
//  Copyright © 2019 Slobodan. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    // MARK: - Properties
    var feedItem: FeedItem? {
        didSet {
            if let title = feedItem?.title {
                titleLabel.text = title
            }
            if let pubDate = feedItem?.publicationDate {
                pubDateLabel.text = pubDate
            }
            if let description = feedItem?.description {
                descriptionLabel.text = description
            }
//            if let imageUrlString = feedItem?.imageUrl {
//                if let imageUrl = URL(string: imageUrlString) {
//                    
//                }
//            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
