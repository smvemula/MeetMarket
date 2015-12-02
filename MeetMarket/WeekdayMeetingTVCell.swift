//
//  WeekdayMeetingTVCell.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 11/12/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class WeekdayMeetingTVCell: UITableViewCell {
    
    @IBOutlet var weekdayLabel: UILabel!
    @IBOutlet var weekdayPercentageLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    var value = 0 {
        didSet {
            self.progressView.tintColor = UIColor.colorForValue(value)
            self.progressView.layer.masksToBounds = true
            self.progressView.layer.cornerRadius = 5.0
            self.progressView.setProgress(Float(value)/100, animated: true)
            self.weekdayPercentageLabel.text = "\(value)%"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
