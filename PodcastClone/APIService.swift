//
//  APIService.swift
//  PodcastClone
//
//  Created by Jacobo Hernandez on 9/17/18.
//  Copyright © 2018 Jacobo Hernandez. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    // singleton
    static let shared = APIService()
    
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
