//
//  SelectMeetingVC.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 12/2/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

protocol SelectedDelegate {
    func selectedNewMeeting(meeting: String)
}

class SelectMeetingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var meetingsTableView: UITableView!
    var delegate: SelectedDelegate?
    
    var meetingArray = ["Create New Meeting"]
    
    func setEditingMode() {
        if !self.meetingsTableView.editing {
            self.meetingsTableView.setEditing(true, animated: true)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "setEditingMode")
        } else {
            self.meetingsTableView.setEditing(false, animated: true)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "setEditingMode")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Select Meeting"
        if let exist = NSUserDefaults.standardUserDefaults().objectForKey("Meetings") as? [String] {
            meetingArray += exist
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "setEditingMode")
    }
    
    func updateArray() {
        meetingArray = ["Create New Meeting"]
        if let exist = NSUserDefaults.standardUserDefaults().objectForKey("Meetings") as? [String] {
            meetingArray += exist
        }
        self.meetingsTableView.reloadData()
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
extension SelectMeetingVC {
    //TableView Row Methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCellWithIdentifier("CELL")  {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CELL")
        }
        
        cell.textLabel?.font = UIFont.boldSystemFontOfSize(15)
        cell.textLabel?.textColor = UIColor.mygreenColor
        cell.detailTextLabel?.font = UIFont.systemFontOfSize(12)
        if indexPath.row == 0 {
            cell.textLabel?.textColor = UIColor.myblueColor
            cell.textLabel?.font = UIFont.systemFontOfSize(15)
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        cell.textLabel?.text = meetingArray[indexPath.row]
        if let meetingInfo = NSUserDefaults.standardUserDefaults().objectForKey(meetingArray[indexPath.row]) as? NSDictionary {
            var tempString = ""
            if let attendees = meetingInfo["attendees"] as? Int {
                tempString = "Attendees \(attendees)"
            }
            if let hourlyRate = meetingInfo["hourlyRate"] as? Int {
                tempString = "\(tempString), Hourly Rate $\(hourlyRate)"
            }
            cell.detailTextLabel?.text = tempString
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0 {
            let newMeetingName = UIAlertController(title: "Meeting Name", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            newMeetingName.view.tintColor = UIColor.myblueColor
            
            newMeetingName.addTextFieldWithConfigurationHandler({textField in
                textField.placeholder = "Enter Meeting name"
                textField.autocapitalizationType = UITextAutocapitalizationType.Sentences
            })
            
            let cancelMeetingName = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { action in
            })
            newMeetingName.addAction(cancelMeetingName)
            
            let okMeetingName = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { action in
                if let exists = self.delegate {
                    if let textTyped = newMeetingName.textFields![0].text {
                        exists.selectedNewMeeting(textTyped)
                        if let exist = NSUserDefaults.standardUserDefaults().objectForKey("Meetings") as? [String] {
                            var temp = exist
                            temp += [textTyped]
                            NSUserDefaults.standardUserDefaults().setObject(temp, forKey: "Meetings")
                        }
                    } else {
                        exists.selectedNewMeeting("New Meeting \(self.meetingArray.count)")
                        if let exist = NSUserDefaults.standardUserDefaults().objectForKey("Meetings") as? [String] {
                            var temp = exist
                            temp += ["New Meeting \(self.meetingArray.count)"]
                            NSUserDefaults.standardUserDefaults().setObject(temp, forKey: "Meetings")
                        }
                    }
                }
                self.navigationController?.popToRootViewControllerAnimated(true)
            })
            newMeetingName.addAction(okMeetingName)
            self.presentViewController(newMeetingName, animated: true, completion: nil)
        } else {
            if let exists = self.delegate {
                exists.selectedNewMeeting(meetingArray[indexPath.row])
            }
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let strinTomove = self.meetingArray[sourceIndexPath.row]
        self.meetingArray.removeAtIndex(sourceIndexPath.row)
        self.meetingArray.insert(strinTomove, atIndex: destinationIndexPath.row)
        var newArray = self.meetingArray
        newArray.removeObject(&newArray, object: "Create New Meeting")
        NSUserDefaults.standardUserDefaults().setObject(newArray, forKey: "Meetings")
    }
    
    /*
    func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        <#code#>
    }*/
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let delete = UIAlertController(title: "Delete", message: "Would you like to delete \(meetingArray[indexPath.row]) ?", preferredStyle: UIAlertControllerStyle.Alert)
            delete.view.tintColor = UIColor.myblueColor
            let cancelMeetingName = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { action in
            })
            delete.addAction(cancelMeetingName)
            
            let okMeetingName = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default, handler: { action in
                if let exist = NSUserDefaults.standardUserDefaults().objectForKey("Meetings") as? [String] {
                    var temp = exist
                    temp.removeObject(&temp, object: self.meetingArray[indexPath.row])
                    NSUserDefaults.standardUserDefaults().setObject(temp, forKey: "Meetings")
                    NSUserDefaults.standardUserDefaults().setObject(nil, forKey: self.meetingArray[indexPath.row])
                    self.updateArray()
                }
            })
            delete.addAction(okMeetingName)
            self.presentViewController(delete, animated: true, completion: nil)
        }
    }
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meetingArray.count
    }
    //TableView Section Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
