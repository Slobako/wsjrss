//
//  FeedParser.swift
//  wsjrss
//
//  Created by Slobodan Kovrlija on 1/30/19.
//  Copyright © 2019 Slobodan. All rights reserved.
//

import Foundation

class FeedParser: NSObject, XMLParserDelegate {
    
    // MARK: - Properties
    static let shared = FeedParser()
    var xmlParser: XMLParser?
    var isHeader = false
    var currentTag = ""
    var tagContent = ""
    var currentItem = FeedItem(title: "", link: "", description: "", imageUrl: "", publicationDate: "", guid: "")
    var arrayOfParsedItems = [FeedItem]()
    
    // MARK: - Methods
    func startParsingContentsFrom(rssUrl: URL, with completion: @ escaping (Bool) -> ()) {
        arrayOfParsedItems.removeAll()
        let parser = XMLParser(contentsOf: rssUrl)
        parser?.delegate = self
        if let flag = parser?.parse() {
            completion(flag)
        }
    }
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
        currentTag = elementName
        
        if elementName == "media:content" {
            currentItem.imageUrl = attributeDict["url"] ?? ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // sometimes the parser will retrieve the characters from same tag in several strings, so that's why concatenation
        if ["title", "link", "description", "pubDate", "guid"].contains(currentTag) {
            tagContent += string
            
            // remove possible html tags:
            tagContent = tagContent.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        }
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        tagContent = tagContent.trimmingCharacters(in: .whitespacesAndNewlines)
        if tagContent.count > 1 {
            
            switch currentTag {
            case "title":
                currentItem.title = tagContent
            case "link":
                currentItem.link = tagContent
            case "description":
                currentItem.description = tagContent
            case "pubDate":
                currentItem.publicationDate = tagContent
            case "guid":
                currentItem.guid = tagContent
            default:
                tagContent = ""
                return
            }
        }
        tagContent = ""
        if elementName == "item" {
            // when feed table view is refreshed, we don't want duplicates showing in the feed
            for feedItem in arrayOfParsedItems {
                if feedItem.guid == currentItem.guid {
                    return
                }
            }
            arrayOfParsedItems.append(currentItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        NotificationCenter.default.post(Notification(name: Notification.Name("ParserFinished")))
        #if DEBUG
        print("FEED ITEMS::: \(arrayOfParsedItems)")
        #endif
    }
}

