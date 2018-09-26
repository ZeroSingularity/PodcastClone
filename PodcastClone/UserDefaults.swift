//
//  UserDefaults.swift
//  PodcastClone
//
//  Created by Jacobo Hernandez on 9/26/18.
//  Copyright © 2018 Jacobo Hernandez. All rights reserved.
//

import Foundation

extension UserDefaults {
    static let favoritedPodcastKey = "favoritedPodcastKey"
    
    func savedPodcasts() -> [Podcast] {
        // Fetch our saved podcasts first
        guard let savedPodcastsData = UserDefaults.standard.data(forKey: UserDefaults.favoritedPodcastKey) else { return [] }
        guard let savedPodcasts = NSKeyedUnarchiver.unarchiveObject(with: savedPodcastsData) as? [Podcast] else { return [] }
        
        return savedPodcasts
    }
}
