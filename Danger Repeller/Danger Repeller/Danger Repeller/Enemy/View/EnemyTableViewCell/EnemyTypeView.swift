//
//  EnemyTypeView.swift
//  Danger Repeller
//
//  Created by Никита Волков on 31.05.2025.
//

import UIKit

// MARK: EnemyTypeView
// Содержит описание каждого типа опасности
final class EnemyTypeView: UIView {
    
    var enemyTypeLabel: UILabel!
    var enemyType: String!
    var enemyDescriptionLabel: UILabel!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UI
extension EnemyTypeView {
    
    private func configureUI() {
        makeViewLayer()
        addImageView()
        addEnemyTypeLabel()
        addEnemyDescriptionLabel()
    }
    
    private func makeViewLayer() {
        layer.borderWidth  = 5
        layer.borderColor  = UIColor.systemBlue.cgColor
        layer.cornerRadius = frame.width / 15
    }
    
    private func addImageView() {
        imageView = UIImageView()
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: frame.width / 20),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: frame.width / 20),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -frame.width / 20),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / 3),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    private func addEnemyTypeLabel(for enemyType: String = "") {
        enemyTypeLabel = UILabel()
        self.addSubview(enemyTypeLabel)
        enemyTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.enemyTypeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: frame.width / 5),
            self.enemyTypeLabel.topAnchor.constraint(equalTo: imageView.topAnchor)
        ])
        enemyTypeLabel.textColor = .blue
        enemyTypeLabel.font = UIFont(
            name: "BigCaslon",
            size: frame.width / 7
        )
    }
    
    private func addEnemyDescriptionLabel() {
        enemyDescriptionLabel = UILabel()
        self.addSubview(enemyDescriptionLabel)
        enemyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enemyDescriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: frame.width / 20),
            enemyDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -frame.width / 20),
            enemyDescriptionLabel.topAnchor.constraint(equalTo: self.enemyTypeLabel.bottomAnchor),
            enemyDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -frame.width / 20)
        ])
        enemyDescriptionLabel.textAlignment = .left
        enemyDescriptionLabel.textColor = .black
        enemyDescriptionLabel.numberOfLines = 0
        enemyDescriptionLabel.font = UIFont(
            name: "SystemFont",
            size: frame.width / 22
        )
    }
    
}
