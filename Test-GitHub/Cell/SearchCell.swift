//
//  SearchCell.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 28.10.2020.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var docImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
