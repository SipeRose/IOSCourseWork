//
//  MainPresenter.swift
//  Danger Repeller
//
//  Created by Никита Волков on 01.06.2025.
//

import UIKit

// MARK: Презентер для главной вью
final class MainPresenter {
    
    weak var enemyVC: EnemiesViewController?
    let enemies = ["Man", "Dogs", "Bears", "Birds", "Hogs"]
    
    func loadView() {
        enemyVC?.configureUI()
    }
    
    /// Создание ячейки EnemyCell
    func configureEnemyCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EnemyCell", for: indexPath) as? EnemyCell else {
            fatalError("Error while making such cell")
        }
        cell.selectionStyle = .none
        let enemyType = enemies[indexPath.row]
        cell.enemyTypeView.imageView.image = UIImage(named: enemyType)
        cell.enemyTypeView.enemyTypeLabel.text = enemyType
        cell.enemyTypeView.enemyDescriptionLabel.text = dangersDescription[enemyType]
        return cell
    }
    
    /// Переход на вью со звуками отпугивания
    func openSoundViewController(from tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tracks = tracksForEveryDanger[enemies[indexPath.row]] else { return }
        let dangerType = enemies[indexPath.row]
        let soundPresenter = SoundPresenter()
        let soundVC = SoundViewController(presenter: soundPresenter)
        soundPresenter.soundVC = soundVC
        soundPresenter.tracksNames = tracks
        soundPresenter.dangerType = dangerType
        enemyVC?.navigationController?.pushViewController(soundVC, animated: true)
    }

}
