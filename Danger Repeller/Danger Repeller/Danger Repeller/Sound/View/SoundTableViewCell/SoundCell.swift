//
//  SoundCell.swift
//  Danger Repeller
//
//  Created by Никита Волков on 01.06.2025.
//

import UIKit

// MARK: SoundCell
final class SoundCell: UITableViewCell {

    var soundView: SoundView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: UI
extension SoundCell {
    private func configureUI() {
        let soundViewWidth  = contentView.bounds.width * 0.9
        let soundViewHeight = contentView.bounds.width * 0.4
        let soundViewFrame = CGRect(
            x: 0,
            y: 0,
            width:  soundViewWidth,
            height: soundViewHeight
        )
        soundView = SoundView(frame: soundViewFrame)
        contentView.addSubview(soundView)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalTo: soundView.heightAnchor, multiplier: 1.1),
            soundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            soundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            soundView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95)
        ])
    }
}
