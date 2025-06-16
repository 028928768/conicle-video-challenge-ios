//
//  CustomAVPlayerViewModelTests.swift
//  conicle-video-challenge-iosTests
//
//  Created by Simon SIwell on 16/6/2568 BE.
//

import XCTest
import AVFoundation
@testable import conicle_video_challenge_ios

final class CustomAVPlayerViewModelTests: XCTestCase {

    func testInitializationWithValidURLCreatesPlayer() {
        let media = Media(title: "Bunny Video", url: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4")
        let viewModel = CustomAVPlayerViewModel(media: media)
        
        XCTAssertEqual(viewModel?.media.title, media.title)
        XCTAssertNotNil(viewModel?.player)
    }
    
    func testInitializationWithInvalidURLDoesNotCreatePlayer() {
        let media = Media(title: "Invalid URL", url: "invalid_url")
        let viewModel = CustomAVPlayerViewModel(media: media)
        
        XCTAssertNil(viewModel?.player)
    }

    func testPlayAndPauseDoNotCrash() {
        let media = Media(title: "Video", url: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4")
        let viewModel = CustomAVPlayerViewModel(media: media)
        
        viewModel?.play()
        viewModel?.pause()
    }
    
    func testSeekDoesNotCrash() {
        let media = Media(title: "Video", url: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4")
        let viewModel = CustomAVPlayerViewModel(media: media)
        
        viewModel?.seek(to: 10.0)
    }
    
    func testFormatTimeCorrectlyFormatsTime() {
        let media = Media(title: "Video", url: "https://example.com/video.mp4")
        let viewModel = CustomAVPlayerViewModel(media: media)
        
        XCTAssertEqual(viewModel?.formatTime(0), "00:00")
        XCTAssertEqual(viewModel?.formatTime(59), "00:59")
        XCTAssertEqual(viewModel?.formatTime(60), "01:00")
        XCTAssertEqual(viewModel?.formatTime(125), "02:05")
        XCTAssertEqual(viewModel?.formatTime(1200), "20:00")
    }
    func testFormatTimeWithGreaterThanHour() {
        let media = Media(title: "Video", url: "https://example.com/video.mp4")
        let viewModel = CustomAVPlayerViewModel(media: media)
        
        let formatted = viewModel?.formatTime(3665) // 1 hour, 1 minute, 5 seconds
        
        XCTAssertEqual(formatted, "61:05", "Expected mm:ss format even for durations over 1 hour")
    }
}
