//
//  CustomAVPlayerViewModel.swift
//  conicle-video-challenge-ios
//
//  Created by Simon SIwell on 15/6/2568 BE.
//

import Foundation
import AVFoundation

final class CustomAVPlayerViewModel {
    private(set) var player: AVPlayer?
    private(set) var media: Media
    private var timeObserverToken: Any?
    
    var durationHandler: ((Float, Float) -> Void )?
    
    init(media: Media) {
        self.media = media
        if let url = URL(string: media.url) {
            let player = AVPlayer(url: url)
            self.player = player
            setupTimeObserver(for: player)
        }
    }
    
    deinit {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
        }
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func seek(to time: Float) {
        let cmTime = CMTime(seconds: Double(time), preferredTimescale: 600)
        player?.seek(to: cmTime)
    }
    
    private func setupTimeObserver(for player: AVPlayer) {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self,
                  let duration = player.currentItem?.duration.seconds,
                  duration.isFinite else { return }
            
            let current = Float(time.seconds)
            let total = Float(duration)
            self.durationHandler?(current, total)
        }
    }
    
}
