//
//  TeamsViewController.swift
//  MVVMExample
//
//  Created by Gustavo Luís Soré on 30/10/19.
//  Copyright © 2019 Sore. All rights reserved.
//

import UIKit

class TeamsViewController: UIViewController {
    
    // MARK: - Properties
    
    fileprivate let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    fileprivate var viewModel: TeamViewModel = TeamViewModel.init(manager: APITeamManager())
    
    // MARK: - Outlets
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.search(name: "Sao")
    }
    
    // MARK: Private Methods
    
    fileprivate func setupUI() {
        view.addSubview(activityIndicator)
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    fileprivate func bindViewModel() {
        viewModel.refreshing.bind(to: activityIndicator.reactive.isAnimating)
        viewModel.teams.bind(to: self) { strongSelf, _ in
            strongSelf.tableView.reloadData()
        }
    }
    
}

extension TeamsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.teams.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.identifier, for: indexPath) as? TeamTableViewCell else {
            return UITableViewCell()
        }
        
        if viewModel.teams.value.count <= indexPath.row {
            return UITableViewCell()
        }
        
        let team: Team = viewModel.teams.value[indexPath.row]
        
        cell.populate(team: team)
        
        return cell
    }
    
}

extension TeamsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
}
