//
//  EpisodesController.swift
//  PodcastClone
//
//  Created by Jacobo Hernandez on 9/18/18.
//  Copyright © 2018 Jacobo Hernandez. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
    var podcast: Podcast? {
        didSet {
            navigationItem.title = podcast?.trackName
            
            fetchEpisodes()
        }
    }
    
    fileprivate func fetchEpisodes() {
        print("Looking for episodes at feed url:", podcast?.feedUrl ?? "")
        
        guard let feedUrl = podcast?.feedUrl else { return }
        
        APIService.shared.fetchEpisodes(feedUrl: feedUrl) { (episodes) in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate let cellId = "cellId"
    
    var episodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigationItem.title = "Episodes"
        setupTableView()
    }
    
    //MARK:- Setup Work
    
    fileprivate func setupTableView() {
        // tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    //MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.episodes[indexPath.row]
        print("Trying to play episode", episode.title)
        
        let window = UIApplication.shared.keyWindow
        // calling .first reaches the first object in the xib file which is the PlayerDetailsView we can do this because we changed the xibs custom class to PlayerDetailsView
        let playerDetailsView = Bundle.main.loadNibNamed("PlayerDetailsView", owner: self, options: nil)?.first as! PlayerDetailsView

        playerDetailsView.episode = episode
        
        playerDetailsView.frame = self.view.frame
        window?.addSubview(playerDetailsView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        let episode = episodes[indexPath.row]
        cell.episode = episode
        
//        cell.textLabel?.numberOfLines = 0
//        cell.textLabel?.text = episode.title! + "\n" + (episode.pubDate?.description)!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
}
