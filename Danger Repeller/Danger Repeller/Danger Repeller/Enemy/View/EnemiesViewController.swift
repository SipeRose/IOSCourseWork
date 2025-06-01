//
//  EnemiesViewController.swift
//  Danger Repeller
//
//  Created by Никита Волков on 31.05.2025.
//

import UIKit

// MARK: EnemiesViewController
// Содержит обзор типов опасностей, чтобы выбрать определенный тип звуков для отпугивания

final class EnemiesViewController: UIViewController {
    
    private var tableView: UITableView!
    private var presenter: MainPresenter
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        presenter.loadView()
    }

}

// MARK: UI
extension EnemiesViewController {
    
    func configureUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.register(EnemyCell.self, forCellReuseIdentifier: "EnemyCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.backgroundColor = .white
    }
}

// MARK: TableView Delegates
extension EnemiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.enemies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.configureEnemyCell(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openSoundViewController(from: tableView, didSelectRowAt: indexPath)
    }
    
}
