//
//  SalaryInfoVC.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 12/7/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class SalaryInfoVC: UIViewController {
    
    @IBOutlet var infoTableView: UITableView!
    
    var dataRates = [24,36,48,60,72,96,120,481,79327]
    var dataSalary = [50000,75000,10000,125000,150000,200000,250000,1000000]
    
    var currentDollar : Int!
    var currentItem: Int!
    
    @IBAction func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if !dataSalary.contains(currentDollar*2080) {
            dataSalary.append(currentDollar*2080)
            dataSalary = dataSalary.sort({return $0 < $1})
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

//MARK: TableViewDelegate & Datasource Methods
extension SalaryInfoVC {
    //TableView Row Methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCellWithIdentifier("CELL")  {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CELL")
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 40))
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.maximumFractionDigits = 0;
        if indexPath.row == self.dataSalary.count {
            cell.textLabel?.text = "Oprah"
            label.text = "$80,000"
        } else {
            cell.textLabel?.text = "\(formatter.stringFromNumber(self.dataSalary[indexPath.row])!)"
            label.text = "\(formatter.stringFromNumber(self.dataSalary[indexPath.row]/2080)!)"
            
            if (self.dataSalary[indexPath.row]/2080) == self.currentDollar {
                cell.textLabel?.textColor = UIColor.myblueColor
                label.textColor = UIColor.myblueColor
            }
        }
        
        cell.accessoryView = label
        
        //let label = UILabel(frame: cg
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSalary.count + 1
    }
    //TableView Section Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //TableView Footer Methods
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRectMake(0,0, self.infoTableView.frame.size.width, 40))
        let sectionTitle = UILabel(frame: CGRectMake(15,0, self.infoTableView.frame.size.width/2 - 15, 40))
        sectionTitle.text = "Average Salary"
        sectionTitle.textAlignment = NSTextAlignment.Left
        sectionTitle.font = UIFont.boldSystemFontOfSize(15)
        sectionTitle.textColor = UIColor.myyellowColor
        sectionView.addSubview(sectionTitle)
        
        let detailTitle = UILabel(frame: CGRectMake(self.infoTableView.frame.size.width/2,0, self.infoTableView.frame.size.width/2 - 15, 40))
        detailTitle.text = "Est. Hourly Rate"
        detailTitle.textAlignment = NSTextAlignment.Right
        detailTitle.font = UIFont.boldSystemFontOfSize(12)
        detailTitle.textColor = UIColor.myredColor
        sectionView.addSubview(detailTitle)
        
        sectionView.backgroundColor = UIColor.whiteColor()
        
        return sectionView
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
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


