//
//  LaunchingVC.swift
//  MeetMarket
//
//  Created by Vemula, Manoj (Contractor) on 11/12/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

import UIKit

class LaunchingVC: UIViewController {
    
    @IBOutlet var indicator : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.indicator.startAnimating()
    }

    override func viewWillDisappear(animated: Bool) {
        self.indicator.stopAnimating()
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
