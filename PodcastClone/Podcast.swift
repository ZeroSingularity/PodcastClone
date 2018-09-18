//
//  Podcast.swift
//  PodcastClone
//
//  Created by Jacobo Hernandez on 9/17/18.
//  Copyright © 2018 Jacobo Hernandez. All rights reserved.
//

import Foundation

struct Podcast: Decodable {
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feedUrl: String?
}

