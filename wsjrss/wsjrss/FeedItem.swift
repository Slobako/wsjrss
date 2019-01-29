//
//  FeedItem.swift
//  wsjrss
//
//  Created by Slobodan on 1/27/19.
//  Copyright © 2019 Slobodan. All rights reserved.
//

import Foundation

struct FeedItem {
    let title: String?
    let link: String?
    let description: String?
    let publicationDate: String?
    
    init(title: String, link: String, description: String, publicationDate: String) {
        self.title = title
        self.link = link
        self.description = description
        self.publicationDate = publicationDate
    }
}
