//
//  CustomAVPlayerViewController.swift
//  conicle-video-challenge-ios
//
//  Created by Simon SIwell on 15/6/2568 BE.
//

import UIKit
import AVFoundation
import AVKit

final class CustomAVPlayerViewController: UIViewController {
    private var playerLayer: AVPlayerLayer?
    var viewModel: CustomAVPlayerViewModel?
    
    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var controlsContainerView: UIView!

    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var pipButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    private var controlsHideTimer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPlayer()
        setupBindings()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(videoTapped))
        videoContainerView.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        title = viewModel?.media.title
        controlsContainerView.alpha = 0
        controlsContainerView.layer.cornerRadius = 10
        controlsContainerView.clipsToBounds = true
    }
    
    private func setupPlayer() {
        guard let player = viewModel?.player else { return }

        let layer = AVPlayerLayer(player:  player)
        layer.frame = videoContainerView.bounds
        layer.videoGravity = .resizeAspect
        videoContainerView.layer.addSublayer(layer)
        playerLayer = layer

        viewModel?.play()
    }

    private func setupBindings() {
        viewModel?.durationHandler = { [weak self] current, duration in
                self?.slider.value = current / duration
        }
    }

    @objc private func videoTapped() {
        if controlsContainerView.alpha == 0 {
            showControls()
        } else {
            resetControlsHideTimer()
        }
    }


    private func showControls() {
        UIView.animate(withDuration: 0.3) {
            self.controlsContainerView.alpha = 1
        }
        resetControlsHideTimer()
    }

    private func hideControls() {
        UIView.animate(withDuration: 0.3) {
            self.controlsContainerView.alpha = 0
        }
        controlsHideTimer?.invalidate()
        controlsHideTimer = nil
    }

    private func resetControlsHideTimer() {
        controlsHideTimer?.invalidate()
        controlsHideTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
            self?.hideControls()
        }
    }
    
    @IBAction func playPauseButtonTapped(_ sender: Any) {
        guard let player = viewModel?.player else { return }

        if player.timeControlStatus == .playing {
            viewModel?.pause()
            playPauseButton.setTitle("Play", for: .normal)
        } else {
            viewModel?.play()
            playPauseButton.setTitle("Pause", for: .normal)
        }

    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        guard let duration = viewModel?.player?.currentItem?.duration.seconds, duration.isFinite else { return }
        let newTime = Float(duration) * sender.value
        viewModel?.seek(to: newTime)
    }

    @IBAction func pipButtonTapped(_ sender: Any) {
        guard AVPictureInPictureController.isPictureInPictureSupported(),
              let playerLayer = playerLayer else { return }

        let pipController = AVPictureInPictureController(playerLayer: playerLayer)
        pipController?.startPictureInPicture()
    }
    
}
