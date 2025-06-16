//
//  YouTubePlayerViewController.swift
//  conicle-video-challenge-ios
//
//  Created by Simon SIwell on 16/6/2568 BE.
//

import UIKit
import YouTubeiOSPlayerHelper

class YouTubePlayerViewController: UIViewController {
    @IBOutlet weak var playerView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Load YouTube video
        playerView.load(withVideoId: "YDWM0RRkyzI", playerVars: [
            "playsinline": 1,  // Play inside the app
            "autoplay": 1,
            "controls": 1,
            "showinfo": 0,
            "modestbranding": 1
        ])
    }
}
