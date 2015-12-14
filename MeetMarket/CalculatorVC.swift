//
//  CalculatorVC.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 11/11/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController, SelectedDelegate {
    
    @IBOutlet var progress: KDCircularProgress!
    @IBOutlet var loadMeetinButton: UIButton!
    @IBOutlet var pausePlayImageView: UIImageView!
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var timeElapsedLabel: UILabel!
    @IBOutlet var meetingCostLabel: UILabel!
    @IBOutlet var employeeHours: UILabel!
    @IBOutlet var numberOfAttendees: UITextField!
    @IBOutlet var avergeCostPerHour: UITextField!
    @IBOutlet var resumeButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var infoButton: UIButton!
    
    var timer = NSTimer()
    var startTime = NSTimeInterval()
    
    var meetingArray = ["New Meeting","Stop & Chat", "Daily Standup", "Product Meeting", "Demos", "Developer Meeting", "Design Meeting","Sprint Planning"]
    
    func getNumberOfPeopleForMeeting(meeting: String) -> Int {
        switch (meeting) {
        case "Stop & Chat":
            return 2
        case "select Meeting":
            return currentNumberOfAttendees
        case "New Meeting":
            self.numberOfAttendees.becomeFirstResponder()
            return 1
        case "1:00-2:30  Labweek Demos":
            return 150
        default:
            return 8
        }
    }
    
    var currentMeeting = "select Meeting"
    
    var currentNumberOfAttendees : Int = 2
    var dollarAmount : Int = 54
    
    func selectedNewMeeting(meeting: String) {
        self.loadMeetinButton.setTitle(meeting, forState: UIControlState.Normal)
        self.resetMeeting()
        self.currentMeeting = meeting
        self.currentNumberOfAttendees = 2
        self.dollarAmount = 54
        if let meetingInfo = NSUserDefaults.standardUserDefaults().objectForKey(meeting) as? NSDictionary {
            if let attendees = meetingInfo["attendees"] as? Int {
                self.currentNumberOfAttendees = attendees
            }
            if let hourlyRate = meetingInfo["hourlyRate"] as? Int {
                self.dollarAmount = hourlyRate
            }
        } else {
            self.numberOfAttendees.becomeFirstResponder()
        }
        self.numberOfAttendees.text = "\(self.currentNumberOfAttendees)"
        self.avergeCostPerHour.text = "$\(self.dollarAmount)"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? SelectMeetingVC {
            vc.delegate = self
        }
        
        if let nc = segue.destinationViewController as? UINavigationController {
            if let vc = nc.topViewController as? SalaryInfoVC {
                self.dismissKeyboard()
                vc.currentDollar = self.dollarAmount
            }
            
        }
    }
    
    func setToDefaultValues() {
        self.timeElapsedLabel.text = "00:00:00"
        self.employeeHours.text = "0:00"
        self.meetingCostLabel.text = "Start"
        self.hideExtraButtons(true)
    }
    
    func hideExtraButtons(hide: Bool) {
        self.resetButton.userInteractionEnabled = !hide
        self.shareButton.enabled = !hide
        if hide {
            self.resetButton.alpha = 0.25
            self.shareButton.alpha = 0.25
        } else {
            self.resetButton.alpha = 1.0
            self.shareButton.alpha = 1.0
        }
        //self.resumeButton.hidden = hide
        
    }
    
    func selectedMeeting(meeting: String) {
        print("Selected Meeting : \(meeting)")
        self.loadMeetinButton.setTitle(meeting, forState: UIControlState.Normal)
    }
    
    func updateTime() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        
        var elapsedTime: NSTimeInterval
        var finalTime : NSTimeInterval
        if let exists = self.resumeTime {
            finalTime = (currentTime -  startTime) + exists
            elapsedTime = (currentTime -  startTime) + exists
        } else {
            finalTime = (currentTime -  startTime)
            elapsedTime = (currentTime -  startTime)
        }
        
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
        
        //let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strHours = String(format: "%02d", hours)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        //let strFraction = String(format: "%d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        let temp = Double(self.currentNumberOfAttendees)
        self.timeElapsedLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
        var cost = String(format: "%.2f", (Double(self.currentNumberOfAttendees)*(finalTime)*Double(self.dollarAmount))/3600)
        
        let emplopyeehours = String(format: "%.2f", (temp*(finalTime))/3600)
        cost = self.currentNumberOfAttendees == 0 ? "0" : cost
        
        self.meetingCostLabel.text = "$\(cost)"
        self.employeeHours.text = "\(emplopyeehours)"
    }
    
    var resumeTime : NSTimeInterval?
    
    var shouldStopAnimating = true
    
    var elapsedTime: NSTimeInterval!
    
    @IBAction func resumeMeeting() {
        shouldStopAnimating = false
        self.meetingCostLabel.backgroundColor = UIColor.clearColor()
        self.meetingCostLabel.textColor = UIColor.myredColor
        self.setProgressToValue(100)
        let aSelector : Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        self.hideExtraButtons(true)
    }
    
    @IBAction func resetMeeting() {
        self.resumeTime = nil
        self.setToDefaultValues()
    }
    
    @IBAction func shareMeeting() {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.showExportOptionWith(image)
        /*
        let imageData = UIImageJPEGRepresentation(image, 1.0) //you can use PNG too
        imageData?.writeToFile("image1.jpeg", atomically: true)*/
    }
    
    func showExportOptionWith(image: UIImage) {
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityVC.title = "Share Your Meeting Cost"
        //New Excluded Activities Code
        let activitiesArray = [UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList]
        
        activityVC.excludedActivityTypes = activitiesArray
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            let pop = UIPopoverController(contentViewController: activityVC)
            pop.presentPopoverFromRect(self.shareButton.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        } else {
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func startStopMeeting() {
        if self.currentNumberOfAttendees > 0 {
            if timer.valid {
                self.meetingCostLabel.backgroundColor = UIColor.myredColor
                self.meetingCostLabel.textColor = UIColor.whiteColor()
                timer.invalidate()
                self.shouldStopAnimating = true
                self.setProgressToValue(0)
                self.hideExtraButtons(false)
                let currentTime = NSDate.timeIntervalSinceReferenceDate()
                if let exists = self.resumeTime {
                    self.resumeTime = (currentTime -  startTime) + exists
                } else {
                    self.resumeTime = (currentTime -  startTime)
                }
                self.pausePlayImageView.image = UIImage(named: "playpause")?.tintWithColor(UIColor.whiteColor())
            } else {
                self.numberOfAttendees.resignFirstResponder()
                self.avergeCostPerHour.resignFirstResponder()
                if !timer.valid {
                    self.pausePlayImageView.image = UIImage(named: "playpause")?.tintWithColor(UIColor.myredColor)
                    self.hideExtraButtons(true)
                    shouldStopAnimating = false
                    self.meetingCostLabel.backgroundColor = UIColor.clearColor()
                    self.meetingCostLabel.textColor = UIColor.myredColor
                    self.setProgressToValue(100)
                    let aSelector : Selector = "updateTime"
                    timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector,     userInfo: nil, repeats: true)
                    startTime = NSDate.timeIntervalSinceReferenceDate()
                }
            }
        }
    }
    
    func addDoneButtonFor(textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace,
            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .Done,
            target: view, action: Selector("endEditing:"))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        textField.inputAccessoryView = keyboardToolbar
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        let image = UIImage(named: "name")
        imageView.image = image
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        
        self.loadMeetinButton.setTitleColor(UIColor.myblueColor, forState: UIControlState.Normal)
        
        self.loadMeetinButton.layer.cornerRadius = 15
        self.loadMeetinButton.layer.borderColor = UIColor.lightGrayColor().CGColor
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
        

        self.meetingCostLabel.backgroundColor = UIColor.myredColor
        self.startStopButton.layer.cornerRadius = 75.0
        self.meetingCostLabel.layer.cornerRadius = 75.0
        self.meetingCostLabel.layer.masksToBounds = true
        self.meetingCostLabel.textColor = UIColor.whiteColor()
        
        self.resetButton.backgroundColor = UIColor.myredColor
        self.resetButton.layer.cornerRadius = 15.0
        self.shareButton.backgroundColor = UIColor.myblueColor
        self.shareButton.layer.cornerRadius = 15.0
        self.hideExtraButtons(true)
        
        self.pausePlayImageView.image = UIImage(named: "playpause")?.tintWithColor(UIColor.whiteColor())
        
        self.updateDate()
        NSTimer.scheduledTimerWithTimeInterval(1000, target: self, selector: "updateDate", userInfo: nil, repeats: true)
        
        self.addDoneButtonFor(self.numberOfAttendees)
        self.addDoneButtonFor(self.avergeCostPerHour)
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        self.infoButton.setImage(UIImage(named: "info_icon")?.tintWithColor(UIColor.myblueColor), forState: UIControlState.Normal)
    }
    
    func dismissKeyboard() {
        self.numberOfAttendees.resignFirstResponder()
        self.avergeCostPerHour.resignFirstResponder()
    }
    
    func updateDate() {
        self.dateLabel.text = "Today's Date: " + NSDate.stringFromDate(NSDate(), format:  "EEEE, MMM d, YYYY")
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

}

extension CalculatorVC {
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.avergeCostPerHour {
            self.avergeCostPerHour.text = self.avergeCostPerHour.text!.stringByReplacingOccurrencesOfString("$", withString: "")
        }
        if self.timer.valid {
            self.startStopMeeting()
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == self.numberOfAttendees {
            self.currentNumberOfAttendees = 2
            if let typed = textField.text {
                if let valid = Int(typed) {
                    self.currentNumberOfAttendees = valid == 0 ? 2 : valid
                    NSUserDefaults.standardUserDefaults().setObject(["attendees":self.currentNumberOfAttendees,"hourlyRate": self.dollarAmount], forKey: self.currentMeeting)
                }
            }
            self.numberOfAttendees.text = "\(self.currentNumberOfAttendees)"
        } else {
            self.dollarAmount = 54
            if let typed = textField.text {
                if let valid = Int(typed) {
                    self.dollarAmount = valid == 0 ? 54 : valid
                    NSUserDefaults.standardUserDefaults().setObject(["attendees":self.currentNumberOfAttendees,"hourlyRate": self.dollarAmount], forKey: self.currentMeeting)
                }
            }
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
