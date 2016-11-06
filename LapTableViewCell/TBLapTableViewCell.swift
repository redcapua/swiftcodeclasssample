//
//  TBLapTableViewCell.swift
//  TimerBox
//

import UIKit

class TBLapTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lapText: UILabel!
    @IBOutlet weak var lapTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
