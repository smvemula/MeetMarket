//
//  ComposeTVCell.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 11/10/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class ComposeTVCell: UITableViewCell {
    
    @IBOutlet var estimatedCostLabel: UILabel!
    @IBOutlet var estimatedCostValue: UILabel!
    @IBOutlet var dateTimeButton: UIButton!
    @IBOutlet var pickerForDateTime: UIDatePicker!
    @IBOutlet var attendeesTextField: UITextField!
    @IBOutlet var heightForPicker: NSLayoutConstraint!
    
    func stringFromDate(date:NSDate, format:String) -> String {
        let newDateFormatter = NSDateFormatter()
        newDateFormatter.dateFormat = format
        
        return newDateFormatter.stringFromDate(date)
    }
    
    var ref: ComposeVC! {
        didSet {
            self.pickerForDateTime.minimumDate = NSDate()
            if self.ref.isDateTimeExpanded {
                self.heightForPicker.constant = 150
            } else {
                self.heightForPicker.constant = 0
            }
        }
    }
    
    @IBAction func updateButtonTitle() {
        //self.dateTimeButton.setTitle(self.stringFromDate(self.pickerForDateTime.date, format: "When: M/d/yyy  h:mm a"), forState: UIControlState.Normal)
        var string = self.stringFromDate(self.pickerForDateTime.date, format: "MM/dd/yyyy h:mm a")
        string = "When: \(string)"
        self.dateTimeButton.setTitle(string, forState: UIControlState.Normal)
    }
    
    @IBAction func expandCollapsePicker() {
        if self.ref.isDateTimeExpanded {
            self.ref.currentHeight = 180
        } else {
            self.ref.currentHeight = 330
        }
        self.ref.isDateTimeExpanded = !self.ref.isDateTimeExpanded
        self.ref.composeTableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
//self.searchTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)

extension ComposeTVCell {
    func textFieldDidBeginEditing(textField: UITextField) {
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
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