//
//  TeamManager.swift
//  MVVMExample
//
//  Created by Gustavo Luís Soré on 30/10/19.
//  Copyright © 2019 Sore. All rights reserved.
//

import Foundation

typealias TeamManagerSearchCompletion = ([Team]?, TeamManagerError?) -> Void

protocol TeamManager {
    func search(search: String, completion: @escaping TeamManagerSearchCompletion)
}

enum TeamManagerError {
    case parse
    case api(APIError)
}

