//
//  ContactsVC.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 11/10/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
//MARK: TableViewDelegate & Datasource Methods
extension ContactsVC {
    //TableView Row Methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCellWithIdentifier("CELL")  {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CELL")
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        cell.textLabel?.text = appDelegate.contacts[indexPath.row]
        cell.detailTextLabel?.text = "Busy - 2 meetings"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.contacts.count
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
