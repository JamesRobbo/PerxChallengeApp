//
//  SearchResultTableViewCell.swift
//  PerxChallenge
//
//  Created by James Robinson on 06/02/2023.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(result: SearchResult?) {
        self.nameLabel.text = result?.genericName
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
    }
}
