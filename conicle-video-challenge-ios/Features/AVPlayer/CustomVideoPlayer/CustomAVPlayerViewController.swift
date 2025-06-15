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
    private var pipController: AVPictureInPictureController?

    
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
        setupAudioSession()
        setupBindings()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(videoTapped))
        videoContainerView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = videoContainerView.bounds
    }
    
    private func setupUI() {
        title = viewModel?.media.title
        controlsContainerView.alpha = 0
        controlsContainerView.layer.cornerRadius = 10
        controlsContainerView.clipsToBounds = true
        controlsContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        currentTimeLabel.text = "00:00"
        durationLabel.text = "--:--"
        slider.value = 0
        
        let configPip = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        let pipImage = UIImage(systemName: "pip.enter", withConfiguration: configPip)
        pipButton.setImage(pipImage, for: .normal)
        pipButton.setTitle("", for: .normal)
        pipButton.tintColor = .white

        
        let configPlay = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium)
        let playImage = UIImage(systemName: "pause.fill", withConfiguration: configPlay)
        playPauseButton.setImage(playImage, for: .normal)
        playPauseButton.setTitle("", for: .normal)
        playPauseButton.imageView?.contentMode = .scaleAspectFit
        playPauseButton.tintColor = .white
    }
    
    private func setupPlayer() {
        guard let player = viewModel?.player else { return }

        let layer = AVPlayerLayer(player:  player)
        layer.frame = videoContainerView.bounds
        layer.videoGravity = .resizeAspect
        videoContainerView.layer.addSublayer(layer)
        playerLayer = layer
        
        if AVPictureInPictureController.isPictureInPictureSupported() {
            pipController = AVPictureInPictureController(playerLayer: layer)
            pipController?.delegate = self
        }

        viewModel?.play()
    }

    private func setupBindings() {
        viewModel?.durationHandler = { [weak self] current, duration in
            guard duration > 0 else { return }
                self?.slider.value = current / duration
            self?.currentTimeLabel.text = self?.formatTime(current)
            self?.durationLabel.text = self?.formatTime(duration)
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

    
    private func formatTime(_ time: Float) -> String {
        let totalSeconds = Int(time)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    @objc private func videoTapped() {
        if controlsContainerView.alpha == 0 {
            showControls()
        } else {
            hideControls()
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
            let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium)
            let playImage = UIImage(systemName: "play.fill", withConfiguration: config)
            playPauseButton.setImage(playImage, for: .normal)

        } else {
            viewModel?.play()
            let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium)
            let playImage = UIImage(systemName: "pause.fill", withConfiguration: config)
            playPauseButton.setImage(playImage, for: .normal)

        }
    }

    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        guard let duration = viewModel?.player?.currentItem?.duration.seconds, duration.isFinite else { return }
        let newTime = Float(duration) * sender.value
        viewModel?.seek(to: newTime)
    }

    @IBAction func pipButtonTapped(_ sender: Any) {
        print("PiP started clicked")
        guard let pipController = pipController else { return }
        print("PiP started clicked guard")
        if pipController.isPictureInPictureActive {
            pipController.stopPictureInPicture()
        } else {
            pipController.startPictureInPicture()
        }
    }
    
}

extension CustomAVPlayerViewController: AVPictureInPictureControllerDelegate {
    func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("PiP started")
    }

    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("PiP stopped")
    }

    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: Error) {
        print("PiP failed: \(error.localizedDescription)")
    }
}
