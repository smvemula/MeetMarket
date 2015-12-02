//
//  ComposeVC.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 11/10/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class ComposeVC: UIViewController {
    
    @IBOutlet var composeTableView: UITableView!
    var currentHeight : CGFloat = 180
    var isDateTimeExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.composeTableView.registerNib(UINib(nibName:"ComposeTVCell", bundle: nil), forCellReuseIdentifier: "compose")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismissVC() {
        self.dismissViewControllerAnimated(true, completion: nil)
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


extension ComposeVC {
    //TableView Row Methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            var  cell: ComposeTVCell? = tableView.dequeueReusableCellWithIdentifier("compose", forIndexPath: indexPath) as? ComposeTVCell
            
            if (cell == nil)
            {
                let nib:Array = NSBundle.mainBundle().loadNibNamed("ComposeTVCell", owner: self, options: nil)
                cell = nib[0] as? ComposeTVCell
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
            }
            
            cell?.ref = self
            var string = cell!.stringFromDate(cell!.pickerForDateTime.date, format: "MM/dd/yyyy h:mm a")
            string = "When: \(string)"
            cell?.dateTimeButton.setTitle(string, forState: UIControlState.Normal)
            
            return cell!
        }
        
        
        var cell : UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCellWithIdentifier("CELL")  {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CELL")
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        cell.textLabel?.text = appDelegate.contacts[indexPath.row - 1]
        cell.detailTextLabel?.text = "Busy - 2 meetings"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.currentHeight
        }
        return 44.0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.contacts.count + 1
    }
    //TableView Section Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    /*
    //TableView Footer Methods
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 44.0
    }
    //TableView Header Methods
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 44.0
    }*/
}