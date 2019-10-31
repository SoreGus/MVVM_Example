//
//  TeamViewModel.swift
//  MVVMExample
//
//  Created by Gustavo Luís Soré on 30/10/19.
//  Copyright © 2019 Sore. All rights reserved.
//

import Bond

class TeamViewModel {
    
    // MARK: - Properties
    
    let teams: Observable<[Team]> = Observable<[Team]>([])
    let error: Observable<TeamManagerError?> = Observable<TeamManagerError?>(nil)
    let refreshing: Observable<Bool> = Observable<Bool>(false)
    
    fileprivate let manager: TeamManager
    
    // MARK: - Initializers
    
    init(manager: TeamManager) {
        self.manager = manager
    }
    
    func search(name: String) {
        refreshing.value = false
        manager.search(search: name) { [weak self] (teams, error) in
            self?.teams.value = teams ?? []
            self?.error.value = error
            self?.refreshing.value = false
        }
    }
    
}
