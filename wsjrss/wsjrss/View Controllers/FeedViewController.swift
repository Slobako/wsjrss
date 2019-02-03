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
    let rssUrlString = "https://www.wsj.com/xml/rss/3_7085.xml"
    var arrayOfFeedItems: [FeedItem] = []
    fileprivate let cellIdentifier = "ItemCell"
    let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(parserFinished),
                                               name: Notification.Name(rawValue: "ParserFinished"),
                                               object: nil)
        
        fetchAndParseFeed()
        setTableView()
    }
    
    func fetchAndParseFeed() {
        if let rssUrl = URL(string: rssUrlString) {
            FeedParser.shared.startParsingContentsFrom(rssUrl: rssUrl) { (flag) in
                if !flag {
                    let alert = UIAlertController(title: "Something went wrong",
                                                  message: "Feed currently unavailable",
                                                  preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func setTableView() {
        feedTableView.tableFooterView = UIView(frame: .zero)
        feedTableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        if #available(iOS 10.0, *) {
            feedTableView.refreshControl = refreshControl
        } else {
            feedTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
    }
    
    // MARK: - Table view data source and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfFeedItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 142
        case .pad:
            return 200
        default:
            return 142
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FeedTableViewCell
        cell.feedItem = arrayOfFeedItems[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let articleViewController = ArticleViewController()
        articleViewController.articleUrlString = arrayOfFeedItems[indexPath.row].link
        let navigationVC = UINavigationController(rootViewController: articleViewController)
        articleViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back",
                                                                                 style: .plain,
                                                                                 target: self,
                                                                                 action: #selector(dismissModal))
        
        present(navigationVC, animated: true, completion: nil)
    }
    
    // MARK: - #selector methods
    @objc func parserFinished() {
        arrayOfFeedItems = FeedParser.shared.arrayOfParsedItems
        feedTableView.reloadData()
        
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }

    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func refreshFeed() {
        fetchAndParseFeed()
    }
}
