//
//  VideoPlayerViewModelTests.swift
//  conicle-video-challenge-iosTests
//
//  Created by Simon SIwell on 16/6/2568 BE.
//

import XCTest
import AVFoundation
@testable import conicle_video_challenge_ios

final class VideoPlayerViewModelTests: XCTestCase {
    
    func testInitializationWithValidURLCreatesPlayer() {
        let media = Media(title: "Bunny Video", url: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4")
        let viewModel = VideoPlayerViewModel(media: media)

        XCTAssertEqual(viewModel.media.title, media.title)
        XCTAssertEqual(viewModel.media.url, media.url)
        XCTAssertNotNil(viewModel.player, "Player should be initialized for valid URL.")
    }
    
    func testInitializationWithInvalidURLDoesNotCreatePlayer() {
        let invalidMedia = Media(title: "Invalid URL", url: "invalid_url")
        let viewModel = VideoPlayerViewModel(media: invalidMedia)

        XCTAssertNil(viewModel.player, "Player should not be created with invalid URL.")
    }
    
    // test play/pause button
    func testPlayAndPauseButton() {
        let media = Media(title: "Bunny Video", url: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4")
        let viewModel = VideoPlayerViewModel(media: media)

        viewModel.play()
        viewModel.pause()
    }

}
