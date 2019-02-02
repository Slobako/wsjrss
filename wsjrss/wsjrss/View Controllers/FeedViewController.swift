//
//  FeedViewController.swift
//  wsjrss
//
//  Created by Slobodan on 1/27/19.
//  Copyright © 2019 Slobodan. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var feedTableView: UITableView!
    
    // MARK: - Properties
    let rssUrlString = "https://online.wsj.com/xml/rss/3_7085.xml"
    var arrayOfFeedItems: [FeedItem] = []
    fileprivate let cellIdentifier = "ItemCell"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(parserFinished), name: Notification.Name(rawValue: "ParserFinished"), object: nil)
        
        if let rssUrl = URL(string: rssUrlString) {
            FeedParser.shared.startParsingContentsFrom(rssUrl: rssUrl) { (flag) in
                if flag {
                    // ... 
                }
            }
        }
        
        feedTableView.tableFooterView = UIView(frame: .zero)
        feedTableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
    }
    
    @objc func parserFinished() {
        arrayOfFeedItems = FeedParser.shared.arrayOfParsedItems
        feedTableView.reloadData()
    }
    
    // MARK: - Table view data source and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfFeedItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FeedTableViewCell
        cell.feedItem = arrayOfFeedItems[indexPath.row]
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
