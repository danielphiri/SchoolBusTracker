//
//  FrontViewController.swift
//  SchoolBusTracker
//
//  Created by Daniel Phiri on 12/27/17.
//  Copyright © 2017 Cophiri. All rights reserved.
//

import UIKit
import FirebaseAuth

class FrontViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Checks if user is already signed in and skips login
//        if Auth.auth().currentUser != nil {
//            if currentParent == nil {
//                currentParent = ParentAccount(userID: (Auth.auth().currentUser?.uid)!)
//                currentParent?.autoFillInfo()
//            }
//            performSegue(withIdentifier: segueFrontPageToMain, sender: self)
//        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
