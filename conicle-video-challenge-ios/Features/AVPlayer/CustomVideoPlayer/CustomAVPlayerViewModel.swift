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
    
    init?(media: Media) {
        guard let url = CustomAVPlayerViewModel.validatedPlayableURL(from: media.url) else {
            print("Invalid media URL: \(media.url)")
            return nil
        }

        self.media = media
        let player = AVPlayer(url: url)
        self.player = player
        setupTimeObserver(for: player)
        setupAudioSession()
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
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session: \(error)")
        }
    }

    
    func formatTime(_ time: Float) -> String {
        let totalSeconds = Int(time)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // MARK: - Validation
    private static func validatedPlayableURL(from string: String) -> URL? {
        guard let url = URL(string: string),
              ["http", "https"].contains(url.scheme?.lowercased()) else {
            return nil
        }
        return url
    }

}
