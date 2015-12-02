//
//  SettingsVC.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 11/12/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet var userPicture: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var uploadPhoto: UIButton!
    @IBOutlet var selectRole: UIButton!
    @IBOutlet var outlook: UIButton!
    @IBOutlet var gmail: UIButton!
    @IBOutlet var signOut: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.userPicture.layer.cornerRadius = self.userPicture.frame.size.width/2
        self.userPicture.layer.masksToBounds = true
        
        self.uploadPhoto.layer.cornerRadius =  12.5
        self.uploadPhoto.layer.borderWidth = 1.0
        self.selectRole.layer.cornerRadius =  12.5
        self.selectRole.layer.borderWidth = 1.0
        self.outlook.layer.cornerRadius =  12.5
        self.outlook.layer.borderWidth = 1.0
        self.gmail.layer.cornerRadius =  12.5
        self.gmail.layer.borderWidth = 1.0
        self.signOut.layer.cornerRadius =  12.5
        self.signOut.layer.borderWidth = 1.0
        self.signOut.backgroundColor = UIColor.myredColor
        self.signOut.layer.borderColor = UIColor.clearColor().CGColor
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
