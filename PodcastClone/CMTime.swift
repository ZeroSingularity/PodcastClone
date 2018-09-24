//
//  CMTime.swift
//  PodcastClone
//
//  Created by Jacobo Hernandez on 9/19/18.
//  Copyright © 2018 Jacobo Hernandez. All rights reserved.
//

import AVKit

extension CMTime {
    func toDisplayString() -> String {
        if CMTimeGetSeconds(self).isNaN {
            return "--:--"
        }
        
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        
        return timeFormatString
    }
}
