//
//  ReportsHeaderView.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 11/12/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class ReportsHeaderView: UIView {
    
    @IBOutlet var progress: KDCircularProgress!
    @IBOutlet var viewTypeSelector: UISegmentedControl!
    @IBOutlet var pickDateType: UIButton!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var meetingsHeader: UILabel!
    @IBOutlet var todayButton: UIButton!
    @IBOutlet var weekButton: UIButton!
    @IBOutlet var monthButton: UIButton!
    @IBOutlet var amountImageView: UIImageView!
    @IBOutlet var peopleImageView: UIImageView!
    @IBOutlet var timeImageView: UIImageView!
    @IBOutlet var meetingOrTeam: UILabel!
    @IBOutlet var percentageOfMeetings: UILabel!
    
    var label : UILabel!
    
    var currentViewModel = "Day"
    
    var tableView: UITableView!
    
    @IBAction func viewTypeChanged(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 2:
            self.meetingsHeader.text = "My Meetings overview"
            self.summaryLabel.text = "100 hours of 320 works hours were involved in meetings this month"
            self.pickDateType.setTitle("Current Month", forState: UIControlState.Normal)
            self.setProgressToValue(32)
        case 1:
            self.meetingsHeader.text = "Week Meetings"
            self.summaryLabel.text = "You've scheduled 2 meetings. The estimated cost of your scheduled meetings is $1200."
            self.pickDateType.setTitle("Current Week", forState: UIControlState.Normal)
            self.setProgressToValue(20)
        default:
            self.meetingsHeader.text = "My Daily Meetings"
            self.summaryLabel.text = "5 meetings or 62% of your workday for meetings"
            self.pickDateType.setTitle("Today", forState: UIControlState.Normal)
            self.setProgressToValue(62)
        }
    }
    
    @IBAction func viewType(sender: UIButton) {
        
        self.todayButton.layer.cornerRadius =  12.5
        self.todayButton.layer.borderWidth = 1.0
        self.todayButton.backgroundColor = UIColor.clearColor()
        self.todayButton.layer.borderColor = UIColor.blackColor().CGColor
        self.todayButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        self.weekButton.layer.cornerRadius =  12.5
        self.weekButton.layer.borderWidth = 1.0
        self.weekButton.backgroundColor = UIColor.clearColor()
        self.weekButton.layer.borderColor = UIColor.blackColor().CGColor
        self.weekButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        
        self.monthButton.layer.cornerRadius =  12.5
        self.monthButton.layer.borderWidth = 1.0
        self.monthButton.backgroundColor = UIColor.clearColor()
        self.monthButton.layer.borderColor = UIColor.blackColor().CGColor
        self.monthButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        sender.layer.cornerRadius =  12.5
        sender.layer.borderWidth = 1.0
        sender.backgroundColor = UIColor.myblueColor
        sender.layer.borderColor = UIColor.clearColor().CGColor
        sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        switch sender.tag {
        case 2:
            self.currentViewModel = "Month"
            self.summaryLabel.text = "42% of Month is scheduled for meetings"
            self.pickDateType.setTitle("Current Month", forState: UIControlState.Normal)
            self.setProgressToValue(42)
        case 1:
            self.currentViewModel = "Week"
            self.summaryLabel.text = "51% of Week is scheduled for meetings"
            self.pickDateType.setTitle("Current Week", forState: UIControlState.Normal)
            self.setProgressToValue(51)
        default:
            self.currentViewModel = "Day"
            self.summaryLabel.text = "82% of Workday is scheduled for meetings"
            self.pickDateType.setTitle("Today", forState: UIControlState.Normal)
            self.setProgressToValue(82)
        }
        
        self.tableView.reloadData()
        
        /*
        switch sender.tag {
        case 1:
        self.organizedButton.layer.cornerRadius =  12.5
        self.organizedButton.layer.borderWidth = 1.0
        self.organizedButton.backgroundColor = UIColor.mygreenColor
        self.organizedButton.layer.borderColor = UIColor.clearColor().CGColor
        case 2:
        self.managedButton.layer.cornerRadius =  12.5
        self.managedButton.layer.borderWidth = 1.0
        self.managedButton.backgroundColor = UIColor.mygreenColor
        self.managedButton.layer.borderColor = UIColor.clearColor().CGColor
        default:
        self.attendedButton.layer.cornerRadius =  12.5
        self.attendedButton.layer.borderWidth = 1.0
        self.attendedButton.backgroundColor = UIColor.mygreenColor
        self.attendedButton.layer.borderColor = UIColor.clearColor().CGColor
        }*/
        
    }
    
    func updateView() {

        //self.pickDateType.layer.cornerRadius =  12.5
        //self.pickDateType.layer.borderWidth = 1.0
        
        progress.startAngle = -90
        progress.progressThickness = 0.3
        progress.trackThickness = 0.1
        progress.clockwise = false
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = true
        progress.glowMode = .Forward
        progress.glowAmount = 0.9
        
        progress.trackColor = UIColor.colorWithHexString("#e2e2e2", andAlpha: 1.0)
        
        label = UILabel(frame: CGRect(x: 25, y: 25, width: 50, height: 50))
        label.text = "\(0)%"
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.adjustsFontSizeToFitWidth = true
        self.progress.addSubview(self.label)
        
        self.pickDateType.setTitleColor(UIColor.myblueColor, forState: UIControlState.Normal)
        
        //self.setProgressToValue(62)
        
        self.viewType(self.todayButton)
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

}
