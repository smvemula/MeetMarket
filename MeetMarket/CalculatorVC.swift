//
//  CalculatorVC.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 11/11/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {
    
    @IBOutlet var progress: KDCircularProgress!
    @IBOutlet var loadMeetinButton: UIButton!
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var timeElapsedLabel: UILabel!
    @IBOutlet var meetingCostLabel: UILabel!
    @IBOutlet var employeeHours: UILabel!
    @IBOutlet var numberOfAttendees: UITextField!
    @IBOutlet var avergeCostPerHour: UITextField!
    
    var timer = NSTimer()
    var startTime = NSTimeInterval()
    
    var meetingArray = ["9:30-11:00  Dev Meeting","11:30-1:30  SEEiT Production Meeting", "1:00-2:30  Labweek Demos", "2:30-3:30 Dev Meeting", "3:30-4:00 SEEiT Production Meeting","4:00-5:00  Sprint Planning","Stop & Chat", "Custom Meeting"]
    
    func getNumberOfPeopleForMeeting(meeting: String) -> Int {
        switch (meeting) {
        case "Stop & Chat":
            return 2
        case "select Meeting":
            return currentNumberOfAttendees
        case "Custom Meeting":
            self.numberOfAttendees.becomeFirstResponder()
            return 1
        case "1:00-2:30  Labweek Demos":
            return 150
        default:
            return 8
        }
    }
    
    var currentMeeting = "select Meeting"
    
    var currentNumberOfAttendees : Int = 0
    var dollarAmount : Int = 54
    
    @IBAction func selectMeetng() {
        if self.meetingCostLabel.text! != "Start" && self.timer.valid {
            self.startStopMeeting()
            self.meetingCostLabel.text = "Start"
            //self.startStopButton.setTitle("Start", forState: UIControlState.Normal)
        }
        let meetingSelector = UIAlertController(title: "select your meeting", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        for each in meetingArray {
            let action = UIAlertAction(title: each, style: UIAlertActionStyle.Default, handler: { action in
                self.selectedMeeting(each)
                self.currentNumberOfAttendees = self.getNumberOfPeopleForMeeting(each)
                self.numberOfAttendees.text = "\(self.currentNumberOfAttendees)"
                self.timeElapsedLabel.text = "00:00:00"
                self.employeeHours.text = "0:00"
                self.meetingCostLabel.text = "Start"
                //self.startStopButton.setTitle("Start", forState: UIControlState.Normal)
            })
            meetingSelector.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        meetingSelector.addAction(cancel)
        self.presentViewController(meetingSelector, animated: true, completion: nil)
    }
    
    func selectedMeeting(meeting: String) {
        print("Selected Meeting : \(meeting)")
        self.loadMeetinButton.setTitle(meeting, forState: UIControlState.Normal)
    }
    
    func updateTime() {
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the hours in elapsed time.
        
        let hours = UInt8(elapsedTime / 3600.0)
        
        elapsedTime -= (NSTimeInterval(hours) * 3600)
        
        //calculate the minutes in elapsed time.
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strHours = String(format: "%02d", hours)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        var temp = Double(self.currentNumberOfAttendees)
        self.timeElapsedLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
        var cost = String(format: "%.2f", (Double(self.currentNumberOfAttendees)*(currentTime -  startTime)*Double(self.dollarAmount))/3600)
        let emplopyeehours = String(format: "%.2f", (temp*(currentTime - startTime))/3600)
        cost = self.currentNumberOfAttendees == 0 ? "0" : cost
        self.meetingCostLabel.text = "$\(cost)"
        //self.startStopButton.setTitle("$\(cost)", forState: UIControlState.Normal)
        self.employeeHours.text = "\(emplopyeehours)"
        
    }
    
    
    var shouldStopAnimating = true
    
    @IBAction func startStopMeeting() {
        if self.currentNumberOfAttendees > 0 {
            self.numberOfAttendees.resignFirstResponder()
            self.avergeCostPerHour.resignFirstResponder()
            if timer.valid {
                //self.startStopButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                //self.startStopButton.backgroundColor = UIColor.myredColor
                self.meetingCostLabel.backgroundColor = UIColor.myredColor
                self.meetingCostLabel.textColor = UIColor.whiteColor()
                timer.invalidate()
                self.shouldStopAnimating = true
                self.setProgressToValue(0)
            } else {
                if !timer.valid {
                    shouldStopAnimating = false
                    self.meetingCostLabel.backgroundColor = UIColor.clearColor()
                    self.meetingCostLabel.textColor = UIColor.myredColor
                    //self.startStopButton.setTitleColor(UIColor.clearColor(), forState: UIControlState.Highlighted)
                    //self.startStopButton.backgroundColor = UIColor.clearColor()
                    self.setProgressToValue(100)
                    let aSelector : Selector = "updateTime"
                    timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector,     userInfo: nil, repeats: true)
                    startTime = NSDate.timeIntervalSinceReferenceDate()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        let image = UIImage(named: "name")
        imageView.image = image
        self.navigationItem.titleView = imageView
        
        
        self.loadMeetinButton.layer.cornerRadius = 15
        self.loadMeetinButton.layer.borderColor = UIColor.blackColor().CGColor
        self.loadMeetinButton.layer.borderWidth = 1.0
        
        progress.startAngle = -90
        progress.progressThickness = 0.2
        progress.trackThickness = 0.05
        progress.clockwise = false
        progress.gradientRotateSpeed = 0.25
        progress.roundedCorners = true
        progress.glowMode = .Forward
        progress.glowAmount = 0.9
        self.view.backgroundColor = UIColor.whiteColor()
        self.progress.repeats = true
        
        progress.trackColor = UIColor.colorWithHexString("#e2e2e2", andAlpha: 1.0)
        
        self.timeElapsedLabel.textColor = UIColor.mygreenColor
        self.employeeHours.textColor = UIColor.myyellowColor
        self.numberOfAttendees.textColor = UIColor.myblueColor
        self.avergeCostPerHour.textColor = UIColor.myblueColor
        

        //self.startStopButton.backgroundColor = UIColor.myredColor
        self.meetingCostLabel.backgroundColor = UIColor.myredColor
        self.startStopButton.layer.cornerRadius = 75.0
        self.meetingCostLabel.layer.cornerRadius = 75.0
        self.meetingCostLabel.layer.masksToBounds = true
        self.meetingCostLabel.textColor = UIColor.whiteColor()
    }
    
    func setProgressToValue(value: Int) {
        
        self.progress.setColors(UIColor.myredColor)
        self.progress.animateToPercentage(value, completion: { completed in
            if completed {
                if !self.shouldStopAnimating {
                    self.setProgressToValue(100)
                }
                //print("animation stopped, completed")
            } else {
                //print("animation stopped, was interrupted")
            }
        })
    }
    
    
    override func viewWillAppear(animated: Bool) {
        if !shouldStopAnimating {
            self.setProgressToValue(100)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//self.searchTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)

extension CalculatorVC {
    func textFieldDidBeginEditing(textField: UITextField) {
        self.avergeCostPerHour.text = self.avergeCostPerHour.text!.stringByReplacingOccurrencesOfString("$", withString: "")
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == self.numberOfAttendees {
            self.currentNumberOfAttendees = Int(textField.text!)!
        } else {
            self.dollarAmount = Int(textField.text!)!
            self.avergeCostPerHour.text = "$\(self.dollarAmount)"
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidChange(textField: UITextField) {
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
