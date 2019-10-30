//
//  Team.swift
//  MVVMExample
//
//  Created by Gustavo Luís Soré on 29/10/19.
//  Copyright © 2019 Sore. All rights reserved.
//

class  Team: Codable {
    var strTeam: String?
    var strTeamBadge: String?
    var strWebsite: String?
    var strCountry: String?
    
    var name: String {
        if let strTeam = strTeam {
            return strTeam
        }
        return ""
    }
    
    var imageURLString: String? {
        if let strTeamBadge = strTeamBadge {
            return strTeamBadge
        }
        return nil
    }
    
    var link: String? {
        if let strWebsite = strWebsite {
            return strWebsite
        }
        return nil
    }
    
    var country: String? {
        if let strCountry = strCountry {
            return strCountry
        }
        return nil
    }
}

struct TeamRoot: Codable {
    var teams: [Team]
}
