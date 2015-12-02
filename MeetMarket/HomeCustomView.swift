//
//  HomeCustomView.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 11/12/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class HomeCustomView: UIView {
    
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var currentSelectionLabel: UILabel!
    @IBOutlet var progress: KDCircularProgress!
    @IBOutlet var userPicture: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var todayButton: UIButton!
    @IBOutlet var weekButton: UIButton!
    var label : UILabel!
    
    var meetingInfoTable: UITableView!
    
     var isToday = true
    
    func updateView() {
        progress.startAngle = -90
        progress.progressThickness = 0.3
        progress.trackThickness = 0.05
        progress.clockwise = false
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = true
        progress.glowMode = .Forward
        progress.glowAmount = 0.9
        
        self.userPicture.layer.cornerRadius = self.userPicture.frame.size.width/2
        self.userPicture.layer.masksToBounds = true
        self.todayButton.layer.cornerRadius = 12.5
        self.todayButton.layer.borderWidth = 1.0
        self.weekButton.layer.cornerRadius = 12.5
        self.weekButton.layer.borderWidth = 1.0
        
        progress.trackColor = UIColor.colorWithHexString("#e2e2e2", andAlpha: 1.0)
        
        label = UILabel(frame: CGRect(x: 30, y: 25, width: 100, height: 100))
        label.text = "\(0)%"
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "HelveticaNeue", size: 30)
        label.adjustsFontSizeToFitWidth = true
        self.progress.addSubview(self.label)
        
        self.tappedOnToday()
    }
    
    @IBAction func tappedOnToday() {
        
        self.summaryLabel.text = "6 Meetings = 6.5 Hours"
        self.currentSelectionLabel.text = "Your Day"
        
        self.weekButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.weekButton.backgroundColor = UIColor.whiteColor()
        self.weekButton.layer.borderColor = UIColor.blackColor().CGColor
        
        self.todayButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.todayButton.backgroundColor = UIColor.colorForValue(82)
        self.todayButton.layer.borderColor = UIColor.clearColor().CGColor
        
        self.setProgressToValue(82)
        self.isToday = true
        self.meetingInfoTable.reloadData()
    }
    
    @IBAction func tappedOnWeek() {
        
        self.summaryLabel.text = "21 Meetings = 21.2 Hours"
        self.currentSelectionLabel.text = "Your Week"
        
        self.todayButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.todayButton.backgroundColor = UIColor.whiteColor()
        self.todayButton.layer.borderColor = UIColor.blackColor().CGColor
        
        self.weekButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.weekButton.backgroundColor = UIColor.colorForValue(53)
        self.weekButton.layer.borderColor = UIColor.clearColor().CGColor
        
        self.setProgressToValue(53)
        
        self.isToday = false
        self.meetingInfoTable.reloadData()
    }
    
    func setProgressToValue(value: Int) {
        label.text = "\(value)%"
        
        self.progress.setColors(UIColor.colorForValue(value))
        self.progress.animateToPercentage(value, completion: { completed in
            if completed {
                //print("animation stopped, completed")
            } else {
                //print("animation stopped, was interrupted")
            }
        })
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
