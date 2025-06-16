//
//  VIdeoPlaylistViewController.swift
//  conicle-video-challenge-ios
//
//  Created by Simon SIwell on 15/6/2568 BE.
//

import UIKit
import AVKit

final class VideoPlaylistViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = VideoPlaylistViewModel()
    var playerType: PlayerType = .systemAVPlayer 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupUI() {
        title = "Playlist"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension VideoPlaylistViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ??
                   UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        let media = viewModel.playlist[indexPath.row]
        cell.textLabel?.text = media.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedMedia = viewModel.playlist[indexPath.row]
        
        switch playerType {
        case .systemAVPlayer:
            let playerVC = VideoPlayerViewController()
            let viewModel = VideoPlayerViewModel(media: selectedMedia)
            playerVC.viewModel = viewModel
            navigationController?.pushViewController(playerVC, animated: true)
        case .customAVPlayer:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let playerVC = storyboard.instantiateViewController(withIdentifier: "CustomAVPlayerViewController") as! CustomAVPlayerViewController
            let viewModel = CustomAVPlayerViewModel(media: selectedMedia)
            playerVC.viewModel = viewModel
            navigationController?.pushViewController(playerVC, animated: true)

        }
        
    }
}
