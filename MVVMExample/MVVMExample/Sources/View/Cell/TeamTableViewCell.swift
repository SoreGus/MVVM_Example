//
//  TeamTableViewCell.swift
//  MVVMExample
//
//  Created by Gustavo Luís Soré on 30/10/19.
//  Copyright © 2019 Sore. All rights reserved.
//

import UIKit
import Kingfisher

class TeamTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "TeamTableViewCell"
    
    // MARK: - Outlets
    
    @IBOutlet var teamImageView: UIImageView!
    @IBOutlet var teamNameLabel: UILabel!
    
    // MARK: - Overrides

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public Methods
    
    func populate(team: Team) {
        
        if
            let imageURLString: String = team.imageURLString,
            let url: URL = URL(string: imageURLString) {
            
            teamImageView.kf.setImage(with: url)
        }
        
        teamNameLabel.text = team.name
    }

}
