//
//  APIService.swift
//  PodcastClone
//
//  Created by Jacobo Hernandez on 9/17/18.
//  Copyright © 2018 Jacobo Hernandez. All rights reserved.
//

import Foundation
import Alamofire
import FeedKit

class APIService {
    
    // singleton
    static let shared = APIService()
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode]) -> ()) {
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        
        guard let url = URL(string: secureFeedUrl) else { return }
        
        // async code for parsing on a separate thread for quick load
        DispatchQueue.global(qos: .background).async {
            print("Before parser")
            let parser = FeedParser(URL: url)
            print("After parser")
            
            parser?.parseAsync(result: { (result) in
                print("Successfully parsed feed:", result.isSuccess)
                
                if let err = result.error {
                    print("Failed to parse XML feed:", err)
                    return
                }
                
                guard let feed = result.rssFeed else { return }
                let episodes = feed.toEpisodes()
                completionHandler(episodes)
            })
        }
    }
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        print("Searching for podcasts...")
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData {
            (dataResponse) in
            if let err = dataResponse.error {
                print("Failed to contact yahoo", err)
                
                return
            }
            
            guard let data = dataResponse.data else { return }
            do {
                print(3)
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
//                self.podcasts = searchResult.results
//                self.tableView.reloadData()
                print(searchResult.resultCount)
                completionHandler(searchResult.results)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
            }
        }
        print(2)
    }
    
    struct SearchResults: Decodable {
        let resultCount: Int
        let results: [Podcast]
    }
}
