//
//  Episode.swift
//  PodcastClone
//
//  Created by Jacobo Hernandez on 9/18/18.
//  Copyright © 2018 Jacobo Hernandez. All rights reserved.
//

import Foundation
import FeedKit

// Encodable and Decodable protocols allow JSON encoder and decoder to automatically know how to encode and decode the properties outside of the Model object
// Using Codable is the combination of Encodable and Decodable
struct Episode: Codable {
    let title: String
    let author: String
    let pubDate: Date
    let description: String
    let streamUrl: String
    
    var fileUrl: String?
    var imageUrl: String?
    
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        self.author = feedItem.iTunes?.iTunesAuthor ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.iTunes?.iTunesSubtitle ?? feedItem.description ?? ""
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
        self.streamUrl = feedItem.enclosure?.attributes?.url ?? ""
    }
}
