//
//  HomeOption.swift
//  conicle-video-challenge-ios
//
//  Created by Simon SIwell on 15/6/2568 BE.
//

import Foundation

enum HomeOption: CaseIterable {
    case avPlayer
    case customAVPlayer
    case youtubePlayer
    
    var title: String {
        switch self {
        case .avPlayer:
            return "AVPlayer (Native)"
        case .customAVPlayer:
            return "AVPlayer (Custom)"
        case .youtubePlayer:
            return "YouTube Player"
        }
    }
    
    var playerType: PlayerType? {
        switch self {
        case .avPlayer: return .systemAVPlayer
        case .customAVPlayer: return .customAVPlayer
        case .youtubePlayer: return nil
        }
    }
}

enum PlayerType {
    case systemAVPlayer
    case customAVPlayer
}
