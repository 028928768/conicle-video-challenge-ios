//
//  AVPlayerViewModel.swift
//  conicle-video-challenge-ios
//
//  Created by Simon SIwell on 15/6/2568 BE.
//

import Foundation
import AVFoundation

class VideoPlayerViewModel {
    // only allow read-only anywhere else to prevent recreation of the player
    private(set) var player: AVPlayer?
    private(set) var media: Media
    
    init(media: Media) {
        self.media = media
        configurePlayer()
        setupAudioSession()
    }
    
    private func configurePlayer() {
        guard let url = URL(string: media.url),
        ["http", "https"].contains(url.scheme?.lowercased()) else {
            print ("Invalid URL string: \(media.url)")
            return
        }
        
        let playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set AVAudioSession: \(error)")
        }
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
}
