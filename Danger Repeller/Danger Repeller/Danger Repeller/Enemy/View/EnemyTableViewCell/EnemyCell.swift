//
//  EnemyCell.swift
//  Danger Repeller
//
//  Created by Никита Волков on 31.05.2025.
//

import UIKit

// MARK: EnemyCell
// Ячейка таблицы типов опасности
final class EnemyCell: UITableViewCell {

    var enemyTypeView: EnemyTypeView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: UI
extension EnemyCell {
    private func configureUI() {
        let enemyTypeViewWidth = contentView.bounds.width * 0.9
        let enemyTypeViewHeight = contentView.bounds.width * 0.4
        let enemyTypeViewFrame = CGRect(
            x: 0,
            y: 0,
            width:  enemyTypeViewWidth,
            height: enemyTypeViewHeight
        )
        enemyTypeView = EnemyTypeView(frame: enemyTypeViewFrame)
        contentView.addSubview(enemyTypeView)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalTo: enemyTypeView.heightAnchor, multiplier: 1.1),
            enemyTypeView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            enemyTypeView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            enemyTypeView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95)
        ])
    }
}
