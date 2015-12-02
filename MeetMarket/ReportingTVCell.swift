//
//  ReportingTVCell.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 11/13/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class ReportingTVCell: UITableViewCell {
    
    @IBOutlet var meetingNameLabel: UILabel!
    @IBOutlet var timeElapsedLabel: UILabel!
    @IBOutlet var numberOfAttendeesLabel: UILabel!
    @IBOutlet var totalAmountSpent : UILabel!
    @IBOutlet var progressView : UIProgressView!
    @IBOutlet var percentage: UILabel!
    
    var meetingAmount: Int! {
        didSet {
            self.percentage.hidden = false
            self.progressView.hidden = false
            self.progressView.tintColor = UIColor.colorForValue(meetingAmount)
            self.progressView.layer.masksToBounds = true
            self.progressView.layer.cornerRadius = 5.0
            self.progressView.setProgress(Float(meetingAmount)/100, animated: true)
            self.percentage.text = "\(meetingAmount)%"
        }
        
    }
    
    var meetingName: String! {
        didSet {
            self.meetingNameLabel.text = meetingName
            self.totalAmountSpent.textColor = UIColor.mygreenColor
            self.numberOfAttendeesLabel.textColor = UIColor.myyellowColor
            self.timeElapsedLabel.textColor = UIColor.myblueColor
            switch meetingName {
                case "Dev Meeting":
                    self.timeElapsedLabel.text = "1.00"
                    self.numberOfAttendeesLabel.text = "16"
                    self.totalAmountSpent.text = "$1,954"
            case "Sprint Planning":
                self.timeElapsedLabel.text = "0.25"
                self.numberOfAttendeesLabel.text = "8"
                self.totalAmountSpent.text = "$620"
            case "Daily Standup":
                self.timeElapsedLabel.text = "1.00"
                self.numberOfAttendeesLabel.text = "3"
                self.totalAmountSpent.text = "$1,200"
            case "SEEiT Weekly Overview":
                self.timeElapsedLabel.text = "0.50"
                self.numberOfAttendeesLabel.text = "6"
                self.totalAmountSpent.text = "$359"
            case "Bi-Weekly Demo":
                self.timeElapsedLabel.text = "0.25"
                self.numberOfAttendeesLabel.text = "5"
                self.totalAmountSpent.text = "$675"
            default:
                self.timeElapsedLabel.text = "1.00"
                self.numberOfAttendeesLabel.text = "2"
                self.totalAmountSpent.text = "$500"
            }
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
