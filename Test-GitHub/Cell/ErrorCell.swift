//
//  ErrorCell.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 29.10.2020.
//

import UIKit

class ErrorCell: UITableViewCell {
    
    @IBOutlet weak var errorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
