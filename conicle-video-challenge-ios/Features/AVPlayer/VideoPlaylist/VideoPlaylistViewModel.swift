//
//  VideoPlaylistViewModel.swift
//  conicle-video-challenge-ios
//
//  Created by Simon SIwell on 15/6/2568 BE.
//

import Foundation

final class VideoPlaylistViewModel {
    var playlist: [Media] = []
    
    init() {
        loadPlaylist()
    }
    
    private func loadPlaylist() {
        playlist = [
            Media(title: "Big Buck Bunny", url: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4"),
            Media(title: "Elephant Dream", url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
            Media(title: "For Bigger Joyrides", url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4")
        ]
    }
    
}
