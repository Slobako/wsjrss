//
//  FeedParser.swift
//  wsjrss
//
//  Created by Slobodan Kovrlija on 1/30/19.
//  Copyright © 2019 Slobodan. All rights reserved.
//

import Foundation

class FeedParser: NSObject, XMLParserDelegate {
    
    var xmlParser: XMLParser?
    var isHeader = false
    var currentTag = ""
    var tagContent = ""
    var currentItem = FeedItem()
    var arrayOfParsedItems = [FeedItem]()
    var sameTag = false
    
    func startParsingContentsFrom(rssUrl: URL, with completion: @ escaping (Bool) -> ()) {
        
        let parser = XMLParser(contentsOf: rssUrl)
        parser?.delegate = self
        if let flag = parser?.parse() {
            
            //arrayOfParsedItems.append(currentItem)
            completion(flag)
        }
    }
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
        // if encountered a new item, put the currently processed in the array of parsed items - better in didEnd
        if elementName == "item" {
            arrayOfParsedItems.append(currentItem)
        }
        
        
        //if currentTag == media ...
        if elementName == "media:content" {
            currentItem.imageUrl = attributeDict["url"] ?? ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // remove possible html tags:
        if ["title", "link", "description", "pubDate"].contains(currentTag) {
            tagContent += string
            tagContent = tagContent.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        }
        
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        if !tagContent.isEmpty {
            tagContent = tagContent.trimmingCharacters(in: .whitespacesAndNewlines)
            
            switch currentTag {
            case "title":
                currentItem.title = tagContent
            case "link":
                currentItem.link = tagContent
            case "description":
                currentItem.description = tagContent
            case "pubDate":
                currentItem.publicationDate = tagContent
            default:
                tagContent = ""
                return
            }
        }
        tagContent = ""
    }
    
    
}

