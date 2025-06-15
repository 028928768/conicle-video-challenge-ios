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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Playlist"
        setupTableView()
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
        // do something
    }
}
