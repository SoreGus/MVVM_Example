//
//  TeamsViewController.swift
//  MVVMExample
//
//  Created by Gustavo Luís Soré on 30/10/19.
//  Copyright © 2019 Sore. All rights reserved.
//

import UIKit
import SafariServices

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
    
    fileprivate func teamAt(indexPath: IndexPath) -> Team? {
        if viewModel.teams.value.count <= indexPath.row {
            return nil
        }
        
        return viewModel.teams.value[indexPath.row]
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
        
        guard let team: Team = teamAt(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        cell.populate(team: team)
        
        return cell
    }
    
}

extension TeamsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let team: Team = teamAt(indexPath: indexPath),
            let link: String = team.link,
            let url: URL = URL.init(string: link) else {
                
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            let safariViewController: SFSafariViewController = SFSafariViewController(url: url)
            safariViewController.delegate = self
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
}

extension TeamsViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
