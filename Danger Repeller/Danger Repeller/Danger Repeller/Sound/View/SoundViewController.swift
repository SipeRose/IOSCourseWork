//
//  SoundViewController.swift
//  Danger Repeller
//
//  Created by Никита Волков on 31.05.2025.
//

import UIKit

// MARK: SoundViewController
/// Содержит звуковые представления с описанием каждого звука
final class SoundViewController: UIViewController, UIScrollViewDelegate {
    
    var presenter: SoundPresenter
    private var tableView: UITableView!
    var alertButton: UIButton!
    
    init(presenter: SoundPresenter) {
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
extension SoundViewController {
    
    func configureUI() {
        view.backgroundColor = .white
        setupAlertButton()
        setupTableView()
    }
    
    private func setupAlertButton() {
        alertButton = UIButton()
        view.addSubview(alertButton)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            alertButton.heightAnchor.constraint(equalTo: alertButton.widthAnchor, multiplier: 1 / 3)
        ])
        alertButton.backgroundColor = .yellow
        alertButton.setTitle("Тревога", for: .normal)
        alertButton.setTitleColor(.black, for: .normal)
        alertButton.layer.cornerRadius = view.frame.width / 20
        alertButton.layer.borderWidth = 3
        alertButton.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.register(SoundCell.self, forCellReuseIdentifier: "SoundCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.backgroundColor = .white
    }

}

// MARK: TableView Delegates
extension SoundViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.tracksNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.configureSoundCell(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectSound(tableView, didSelectRowAt: indexPath)
    }
    
}
