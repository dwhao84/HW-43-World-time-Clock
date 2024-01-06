//
//  CitySelectionTableViewCell.swift
//  HW#43-World time Clock
//
//  Created by Da-wei Hao on 2024/1/6.
//

import UIKit

class CitySelectionTableViewCell: UITableViewCell {

    static let identifer: String = "CitySelectionTableViewCell"
    
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor       = SystemColor.citySelectionBackgroundColor
        
        countryLabel.text          = "Taiwan / Taipei"
        countryLabel.textColor     = SystemColor.white
        countryLabel.textAlignment = .left
        countryLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CitySelectionTableViewCell", bundle: nil)
    }
    
}
