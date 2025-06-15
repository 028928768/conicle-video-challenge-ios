//
//  HomeOption.swift
//  conicle-video-challenge-ios
//
//  Created by Simon SIwell on 15/6/2568 BE.
//

import Foundation

enum HomeOption: CaseIterable {
    case avPlayer
    case youtubePlayer
    
    var title: String {
        switch self {
        case .avPlayer:
            return "AVPlayer (Native)"
        case .youtubePlayer:
            return "YouTube Player"
        }
    }
}

