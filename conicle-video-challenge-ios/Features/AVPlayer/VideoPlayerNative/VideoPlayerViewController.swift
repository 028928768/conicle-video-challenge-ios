//
//  AVPlayerViewController.swift
//  conicle-video-challenge-ios
//
//  Created by Simon SIwell on 15/6/2568 BE.
//

import UIKit
import AVKit

final class VideoPlayerViewController: AVPlayerViewController {
    var viewModel: VideoPlayerViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
        setupPiP()
    }

    private func setupPlayer() {
        guard let player = viewModel?.player else {
            print("No player available")
            return
        }
        
        self.player = player
        self.showsPlaybackControls = true
        viewModel?.play()
    }
    
    private func setupPiP() {
        self.allowsPictureInPicturePlayback = true
        self.canStartPictureInPictureAutomaticallyFromInline = true
    }
}
