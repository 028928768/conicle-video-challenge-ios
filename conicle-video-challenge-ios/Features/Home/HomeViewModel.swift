//
//  HomeViewModel.swift
//  conicle-video-challenge-ios
//
//  Created by Simon SIwell on 15/6/2568 BE.
//

import Foundation
import YouTubeiOSPlayerHelper

final class HomeViewModel {
    let options: [HomeOption] = HomeOption.allCases
    
    func title(for index: Int) -> String {
        return options[index].title
    }
    
    func option(at index: Int) -> HomeOption? {
        guard options.indices.contains(index) else { return nil }
        return options[index]
    }
    
    var count: Int {
        return options.count
    }
}
