//
//  ViewController.swift
//  conicle-video-challenge-ios
//
//  Created by Simon SIwell on 15/6/2568 BE.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        title = "Video Players"
        view.backgroundColor = .systemBackground
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.options.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ??
        UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = viewModel.title(for: indexPath.row)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedOption = viewModel.option(at: indexPath.row)
        
        switch selectedOption {
        case .avPlayer, .customAVPlayer:
            guard let playerType = selectedOption.playerType else { return }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "VideoPlaylistViewController") as? VideoPlaylistViewController {
                vc.playerType = playerType
                navigationController?.pushViewController(vc, animated: true)
            }
            
        case .youtubePlayer:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let youtubeVC = storyboard.instantiateViewController(withIdentifier: "YouTubePlayerViewController") as? YouTubePlayerViewController {
                navigationController?.pushViewController(youtubeVC, animated: true)
            }
            
        }
        
    }
}

