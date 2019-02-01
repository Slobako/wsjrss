//
//  FeedViewController.swift
//  wsjrss
//
//  Created by Slobodan on 1/27/19.
//  Copyright © 2019 Slobodan. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    let rssUrlString = "https://online.wsj.com/xml/rss/3_7085.xml"
    var arrayOfFeedItems: [FeedItem] = []
    fileprivate let identifier = "ItemCell"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let rssUrl = URL(string: rssUrlString) {
            FeedParser().startParsingContentsFrom(rssUrl: rssUrl) { (flag) in
                if flag {
                    // ... 
                }
            }
        }
        
        
        
    }
    
    // MARK: - Table view data source and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfFeedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as UITableViewCell
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
