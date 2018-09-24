//
//  UIApplication.swift
//  PodcastClone
//
//  Created by Jacobo Hernandez on 9/24/18.
//  Copyright © 2018 Jacobo Hernandez. All rights reserved.
//

import UIKit

extension UIApplication {
    static func mainTabBarController() -> MainTabBarController? {
        // UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
        
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}
