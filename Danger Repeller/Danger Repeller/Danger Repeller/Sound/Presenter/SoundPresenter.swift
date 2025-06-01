//
//  SoundPresenter.swift
//  Danger Repeller
//
//  Created by Никита Волков on 01.06.2025.
//

import UIKit
import AVFoundation

// MARK: Презентер для вью со звуками
final class SoundPresenter {
    
    weak var soundVC: SoundViewController?
    var tracksNames = [String]()
    var dangerType: String!
    
    func loadView() {
        soundVC?.configureUI()
        soundVC?.alertButton.addTarget(self, action: #selector(callAlert), for: .touchUpInside)
        addSwipeGestureRecognizer()
    }
    
    /// Свайп для возвращения на главный экран
    private func addSwipeGestureRecognizer() {
        let swipeFromLeftToTheRightGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(getToEnemiesViewController)
        )
        swipeFromLeftToTheRightGestureRecognizer.direction = .right
        soundVC?.view.addGestureRecognizer(swipeFromLeftToTheRightGestureRecognizer)
    }
    
    @objc private func getToEnemiesViewController() {
        stopSound()
        soundVC?.navigationController?.popViewController(animated: true)
    }
    
    func configureSoundCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as? SoundCell else {
            fatalError("Error while making such cell")
        }
        cell.selectionStyle = .none
        let trackName = tracksNames[indexPath.row]
        cell.soundView.nameOfSoundLabel.text = trackName
        cell.soundView.soundDescriptionLabel.text = soundsDescription[trackName]
        cell.soundView.presenter = self
        return cell
    }
    
    /// Включение выбранного звука
    func selectSound(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SoundCell else { return }
        guard let soundView = cell.soundView else { return }
        guard let tappedView = SoundView.tappedSoundView else {
            soundView.addTapAnimation(isPlaying: true)
            playSound(from: soundView)
            return
        }
        if tappedView != soundView {
            soundView.addTapAnimation(isPlaying: true)
            stopSound()
            playSound(from: soundView)
        } else {
            soundView.addTapAnimation(isPlaying: false)
            stopSound()
        }
    }
    
    private func playSound(from soundView: SoundView) {
        SoundView.tappedSoundView = soundView
        SoundView.soundName = soundView.nameOfSoundLabel.text!
        if let path = Bundle.main.url(forResource: SoundView.soundName, withExtension: "mp3") {
            if let sound = try? AVAudioPlayer(contentsOf: path) {
                SoundView.audioPlayer = sound
                SoundView.audioPlayer!.delegate = soundView
                sound.play()
            }
        }
    }
    
    func stopSound() {
        SoundView.tappedSoundView?.playingLabel.text = ""
        SoundView.tappedSoundView = nil
        guard let _ = SoundView.audioPlayer else { return }
        if SoundView.audioPlayer!.isPlaying {
            SoundView.audioPlayer!.stop()
            SoundView.soundName = ""
        }
    }
    
    /// Отправка сигнала тревоги
    @objc private func callAlert() {
        UIView.animate(withDuration: 0.5) {
            self.soundVC?.alertButton.backgroundColor = .red
        }
        AlarmNetrworkClient.postAlarm(about: dangerType)
        let ac = UIAlertController(title: "Тревога", message: "Сообщение о тревоге отправлено в соответствующую службу. Сохраняйте спокойствие, помощь уже в пути!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel) {_ in
            UIView.animate(withDuration: 0.5) {
                self.soundVC?.alertButton.backgroundColor = .yellow
            }
        })
        soundVC?.present(ac, animated: true)
    }
    
}
