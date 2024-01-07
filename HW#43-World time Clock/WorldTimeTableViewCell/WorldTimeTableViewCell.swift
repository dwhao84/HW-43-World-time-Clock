//
//  WorldTimeTableViewCell.swift
//  HW#43-World time Clock
//
//  Created by Da-wei Hao on 2024/1/6.
//

import UIKit

class WorldTimeTableViewCell: UITableViewCell {
    
    static let identifer: String = "WorldTimeTableViewCell"
    
    @IBOutlet weak var dateStatusLabel: UILabel!
    @IBOutlet weak var timeDifferenceLabel: UILabel!
    @IBOutlet weak var cityNameLabel:      UILabel!
    @IBOutlet weak var nowTimeLabel:       UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = SystemColor.black
        
        nowTimeLabel.adjustsFontSizeToFitWidth       = true
        cityNameLabel.adjustsFontSizeToFitWidth      = true
        dateStatusLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "WorldTimeTableViewCell", bundle: nil)
    }
}
