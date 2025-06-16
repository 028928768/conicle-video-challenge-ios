//
//  VideoPlaylistViewModelTest.swift
//  conicle-video-challenge-iosTests
//
//  Created by Simon SIwell on 16/6/2568 BE.
//

import XCTest
@testable import conicle_video_challenge_ios


final class VideoPlaylistViewModelTests: XCTestCase {
    var viewModel: VideoPlaylistViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = VideoPlaylistViewModel()
    }
    
    func testPlaylistIsNotEmpty() {
        XCTAssertFalse(viewModel.playlist.isEmpty, "Playlist should not be empty after initialization.")
    }

    func testPlaylistHasExpectedNumberOfVideos() {
        XCTAssertEqual(viewModel.playlist.count, 3, "Playlist should contain exactly 3 videos.")
    }

    func testFirstVideoDetailsAreCorrect() {
        let first = viewModel.playlist.first
        XCTAssertEqual(first?.title, "Big Buck Bunny")
        XCTAssertEqual(first?.url, "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4")
    }

    func testAllVideosHaveValidURLs() {
        for media in viewModel.playlist {
            XCTAssertNotNil(URL(string: media.url), "Invalid URL for media: \(media.title)")
        }
    }

}
