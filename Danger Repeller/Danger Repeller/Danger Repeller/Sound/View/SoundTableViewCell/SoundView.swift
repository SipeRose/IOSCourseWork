//
//  SoundView.swift
//  Danger Repeller
//
//  Created by Никита Волков on 31.05.2025.
//

import UIKit
import AVFoundation

// MARK: SoundView
// Содержит описание каждого звука для отпугивания и является делегатом плеера
class SoundView: UIView {
    
    static var audioPlayer: AVAudioPlayer?
    static var soundName = ""
    static var tappedSoundView: SoundView?
    var presenter: SoundPresenter!
    
    var nameOfSoundLabel = UILabel()
    private var imageView = UIImageView()
    var playingLabel = UILabel()
    var soundDescriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: AVAudioPlayerDelegate
extension SoundView: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            presenter.stopSound()
        }
    }
}

// MARK: UI
extension SoundView {
    
    private func configureUI() {
        makeViewLayer()
        addImageView()
        addPlayingLabel()
        addTrackNameLabel()
        addSoundDescriptionLabel()
    }
    
    private func makeViewLayer() {
        layer.borderWidth  = 5
        layer.borderColor  = UIColor.systemBlue.cgColor
        layer.cornerRadius = frame.width / 15
    }
    
    private func addImageView() {
        let constant = frame.width / 20
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constant),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: constant),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2 * constant),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / 4),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        imageView.image = UIImage(named: "SoundImage")
    }
    
    private func addTrackNameLabel(with trackName: String = "") {
        let constant = frame.width * 0.05
        self.addSubview(nameOfSoundLabel)
        nameOfSoundLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameOfSoundLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: constant),
            nameOfSoundLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constant)
        ])
        let fontSize = (trackName.count > 18) ? (frame.width / 17) : (frame.width / 14)
        nameOfSoundLabel.font = UIFont(
            name: "BigCaslon",
            size: fontSize
        )
        nameOfSoundLabel.text = ""
        nameOfSoundLabel.textColor = .blue
    }
    
    private func addPlayingLabel() {
        let constant = frame.width * 0.01
        self.addSubview(playingLabel)
        playingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playingLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: constant),
            playingLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
        playingLabel.text = ""
        playingLabel.textColor = .systemRed
        playingLabel.font = UIFont(
            name: "SystemFont",
            size: frame.width / 23
        )
    }
    
    private func addSoundDescriptionLabel() {
        let constant = frame.width * 0.01
        self.addSubview(soundDescriptionLabel)
        soundDescriptionLabel.numberOfLines = 0
        soundDescriptionLabel.font = UIFont(
            name: "SystemFont",
            size: frame.width / 20
        )
        soundDescriptionLabel.text = soundsDescription[nameOfSoundLabel.text!]
        soundDescriptionLabel.textColor = .black
        soundDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            soundDescriptionLabel.leadingAnchor.constraint(equalTo: nameOfSoundLabel.leadingAnchor),
            soundDescriptionLabel.topAnchor.constraint(equalTo: nameOfSoundLabel.bottomAnchor, constant: constant),
            soundDescriptionLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor)
        ])
    }
    
    func addTapAnimation(isPlaying: Bool) {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(
                scaleX: 0.9,
                y: 0.9
            )
        }
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
            if isPlaying {
                self.playingLabel.text = "Playing"
            } else {
                self.playingLabel.text = ""
            }
        }
    }
    
}
