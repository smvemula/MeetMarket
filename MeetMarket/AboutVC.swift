//
//  AboutVC.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 12/18/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit
import MessageUI

class AboutVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var contactUsTextView: UITextView!
    @IBOutlet var emailButton: UIButton!
    
    var subject = "MeetMarket Feedback"
    var email = "meetmarketfeedback@gmail.com"
    var message = "Hello MeetMarket Team"
    
    @IBAction func emailUs() {
        
        let mailSelector = UIAlertController(title: "Feedback", message: "Please select an email app to send your feedback.", preferredStyle: UIAlertControllerStyle.Alert)
        mailSelector.view.tintColor = UIColor.myblueColor
        
        let mailiOS = UIAlertAction(title: "Mail", style: UIAlertActionStyle.Default, handler: { action in
            if MFMailComposeViewController.canSendMail() {
                
                let mc: MFMailComposeViewController = MFMailComposeViewController()
                mc.mailComposeDelegate = self
                mc.setToRecipients([self.email])
                mc.setSubject(self.subject)
                mc.setMessageBody(self.message, isHTML: false)
                
                self.presentViewController(mc, animated: true, completion: nil)
            } else {
                UIAlertView.showAlertView("Mail Not configured", text: "iOS Mail app is not configured to send email. Please try again later.")
                print("cannot send mails")
            }
        })
        mailSelector.addAction(mailiOS)
        
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "googlegmail://")!)
        {
            let GmailiOS = UIAlertAction(title: "Gmail", style: UIAlertActionStyle.Default, handler: { action in
                let url = "googlegmail:///co?to=\(self.email)subject=\(self.subject)&body=\(self.message)"
                UIApplication.sharedApplication().openURL(NSURL(string: url.stringByReplacingOccurrencesOfString(" ", withString: "%20"))!)
            })
            mailSelector.addAction(GmailiOS)
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        mailSelector.addAction(cancel)

        self.presentViewController(mailSelector, animated: true, completion: {
            mailSelector.view.tintColor = UIColor.myblueColor
        })
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result {
        case MFMailComposeResultCancelled:
            print("Mail cancelled")
        case MFMailComposeResultSaved:
            print("Mail saved")
        case MFMailComposeResultSent:
            print("Mail sent")
        case MFMailComposeResultFailed:
            print("Mail sent failure: \(error?.localizedDescription)")
        default:
            break
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.summaryLabel.text = "We're creating tools\nto make your meetings better."
        self.contactUsTextView.text = "Stay with us as we release new features.\nVisit us at getmeetmarket.com\nFound a bug? Got some feedback?"
        self.contactUsTextView.tintColor = UIColor.myblueColor
        self.emailButton.backgroundColor = UIColor.myblueColor
        self.emailButton.layer.cornerRadius = 15.0
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
