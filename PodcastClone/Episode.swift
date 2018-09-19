//
//  Episode.swift
//  PodcastClone
//
//  Created by Jacobo Hernandez on 9/18/18.
//  Copyright © 2018 Jacobo Hernandez. All rights reserved.
//

import Foundation
import FeedKit

struct Episode {
    let title: String
    let author: String
    let pubDate: Date
    let description: String
    let streamUrl: String
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
