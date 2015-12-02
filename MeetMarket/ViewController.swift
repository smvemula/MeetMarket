//
//  ViewController.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 11/9/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var meetingInfoTable: UITableView!
    
    var header : HomeCustomView!
    
     var meetingArray = ["9:30-11:00  Dev Meeting","11:30-1:30  SEEiT Production Meeting", "1:30-2:30  UX Review", "2:30-3:30 Sprint Review", "3:30-4:00 SEEiT Production Meeting","4:00-5:00  Sprint Planning"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.22, alpha: 1)
        
        //progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

        let nib:Array = NSBundle.mainBundle().loadNibNamed("HomeCustomView", owner: self, options: nil)
        let header = nib[0] as? HomeCustomView
        header!.meetingInfoTable = self.meetingInfoTable
        header!.frame = CGRectMake(0, 0, self.view.frame.size.width, 380)
        self.header = header!
        self.header.updateView()
        self.meetingInfoTable.tableHeaderView = header!
        self.view.backgroundColor = UIColor.whiteColor()
        self.meetingInfoTable.registerNib(UINib(nibName:"WeekdayMeetingTVCell", bundle: nil), forCellReuseIdentifier: "weekday")
    }
    

    
    override func viewDidAppear(animated: Bool) {
        //self.tappedOnToday()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: TableViewDelegate & Datasource Methods
extension ViewController {
    //TableView Row Methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if self.header.isToday {
            var cell : UITableViewCell
            
            if let reuseCell = tableView.dequeueReusableCellWithIdentifier("CELL")  {
                cell = reuseCell
            } else {
                cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CELL")
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 12)
            cell.textLabel?.text = self.meetingArray[indexPath.row]
            return cell
        } else {
            var  cell: WeekdayMeetingTVCell? = tableView.dequeueReusableCellWithIdentifier("weekday", forIndexPath: indexPath) as? WeekdayMeetingTVCell
            
            if (cell == nil)
            {
                let nib:Array = NSBundle.mainBundle().loadNibNamed("WeekdayMeetingTVCell", owner: self, options: nil)
                cell = nib[0] as? WeekdayMeetingTVCell
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
            }
            
            switch indexPath.row {
            case 0:
                cell?.weekdayLabel.text = "MON"
                cell?.value = 82
            case 1:
                cell?.weekdayLabel.text = "TUE"
                cell?.value = 41
            case 2:
                cell?.weekdayLabel.text = "WED"
                cell?.value = 47
            case 3:
                cell?.weekdayLabel.text = "THU"
                cell?.value = 44
            default:
                cell?.weekdayLabel.text = "FRI"
                cell?.value = 59
            }
            
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40.0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        header!.frame = CGRectMake(0, 0, self.view.frame.size.width, 380)
        if self.header.isToday {
        return self.meetingArray.count
        }
        return 5
    }
    //TableView Section Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}

