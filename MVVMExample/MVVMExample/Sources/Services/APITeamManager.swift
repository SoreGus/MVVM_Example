//
//  APITeamManager.swift
//  MVVMExample
//
//  Created by Gustavo Luís Soré on 29/10/19.
//  Copyright © 2019 Sore. All rights reserved.
//

import Foundation

class APITeamManager: TeamManager {
    
    // MARK: - Public Methods
    
    func search(search: String, completion: @escaping TeamManagerSearchCompletion) {
        let composedURLString: String = "\(Constants.searchTeamURLString)\(search)"
        API.get(urlString: composedURLString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let teamRoot: TeamRoot = try JSONDecoder().decode(TeamRoot.self, from: data)
                    completion(teamRoot.teams, nil)
                } catch {
                    completion(nil, .parse)
                }
            case .failure(let error):
                completion(nil, .api(error))
            }
        }
    }
    
}
