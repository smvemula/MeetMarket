//
//  ReportingVC.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 11/11/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class ReportingVC: UIViewController {
    
    @IBOutlet var reportsTableView: UITableView!
    @IBOutlet var changeView: UIBarButtonItem!
    
    var meetingArray = ["Dev Meeting","Sprint Planning","Daily Standup","SEEiT Weekly Overview","Bi-Weekly Demo","Bi Weekly 1:1"]
    var peopleArray = ["Christian Petersen", "Manoj Vemula", "Janette Salazar", "Pratyusha Desu", "Mike Fine", "Dauren Tatubaev"]
    var peopleCostArray = ["Day": [78, 28, 16, 40, 23, 80], "Week": [68, 15, 13, 35, 56, 60], "Month": [53, 18, 24, 30, 49, 28]]
    
    var header: ReportsHeaderView!
    
    var options = ["Attendee", "Organizer", "Manager"]
    var currentViewMode = "Manager"
    
    @IBAction func changeViewType() {
        let meetingSelector = UIAlertController(title: "select your meeting", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        for each in options {
            let action = UIAlertAction(title: each, style: UIAlertActionStyle.Default, handler: { action in
                self.currentViewMode = each
                self.updateViewPerType()
            })
            meetingSelector.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        meetingSelector.addAction(cancel)
        //self.press
        
        //if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiomPad {
            //activity.popoverPresentationController.sourceView = shareButtonBarItem;
            
            //meetingSelector.popoverPresentationController.barButtonItem = self.navigationController?.navigationItem.leftBarButtonItem;
            
            
            //[self presentViewController:activity animated:YES completion:nil];
            
       // }
       // [self presentViewController:activity animated:YES completion:nil];
        self.presentViewController(meetingSelector, animated: true, completion: nil)
        
    }
    
    @IBAction func showExportOptionWithArray() {
            let activityVC = UIActivityViewController(activityItems: ["Weekly Report"], applicationActivities: nil)
            
            activityVC.title = "Share Your Report! App Download URL"
            //New Excluded Activities Code
            var activitiesArray = [UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList]
            
            activityVC.excludedActivityTypes = activitiesArray
            self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    func updateViewPerType() {
        self.changeView.title = self.currentViewMode
        self.header.amountImageView.hidden = false
        self.header.peopleImageView.hidden = false
        self.header.timeImageView.hidden = false
        self.header.percentageOfMeetings.hidden = true
        self.header.meetingOrTeam.text = "Meeting name"
        switch self.currentViewMode {
        case "Attendee":
            self.header.meetingsHeader.text = "Your Meetings"
            self.header.amountImageView.hidden = true
        case "Manager":
            self.header.meetingOrTeam.text = "Team Members"
            self.header.meetingsHeader.text = "Team Meetings"
            self.header.percentageOfMeetings.hidden = false
            self.header.amountImageView.hidden = true
            self.header.peopleImageView.hidden = true
            self.header.timeImageView.hidden = true
        default:
            self.header.meetingsHeader.text = "Organized Meetings"
            
        }
        self.reportsTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib:Array = NSBundle.mainBundle().loadNibNamed("ReportsHeaderView", owner: self, options: nil)
        let header = nib[0] as? ReportsHeaderView
        header!.frame = CGRectMake(0, 0, self.view.frame.size.width, 290)
        self.header = header!
        self.header.tableView = self.reportsTableView
        self.header.updateView()
        self.reportsTableView.tableHeaderView = header!
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.reportsTableView.registerNib(UINib(nibName:"ReportingTVCell", bundle: nil), forCellReuseIdentifier: "report")
        
        self.updateViewPerType()
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
//MARK: TableViewDelegate & Datasource Methods
extension ReportingVC {
    //TableView Row Methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var  cell: ReportingTVCell? = tableView.dequeueReusableCellWithIdentifier("report", forIndexPath: indexPath) as? ReportingTVCell
        
        if (cell == nil)
        {
            let nib:Array = NSBundle.mainBundle().loadNibNamed("ReportingTVCell", owner: self, options: nil)
            cell = nib[0] as? ReportingTVCell
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        
        if self.currentViewMode == "Manager" {
            cell?.meetingName = self.peopleArray[indexPath.row]
        } else {
            cell?.meetingName = self.meetingArray[indexPath.row]
        }
        
        cell?.totalAmountSpent.hidden = false
        cell?.numberOfAttendeesLabel.hidden = false
        cell?.timeElapsedLabel.hidden = false
        cell?.progressView.hidden = true
        cell?.percentage.hidden = true
        
        switch self.currentViewMode {
        case "Attendee":
            cell?.totalAmountSpent.hidden = true
        case "Manager":
            if let array = self.peopleCostArray[self.header.currentViewModel] {
                cell?.meetingAmount = array[indexPath.row]
            }
            cell?.numberOfAttendeesLabel.hidden = true
            cell?.timeElapsedLabel.hidden = true
            cell?.totalAmountSpent.hidden = true
            self.header.meetingsHeader.text = "Team Meetings"
        default:
            self.header.meetingsHeader.text = "Organized Meetings"
            
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40.0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        header!.frame = CGRectMake(0, 0, self.view.frame.size.width, 290)
        if self.currentViewMode == "Manager" {
            return self.peopleArray.count
        }
        return self.meetingArray.count
    }
    //TableView Section Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
