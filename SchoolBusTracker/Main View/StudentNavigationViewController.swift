//
//  StudentNavigationViewController.swift
//  SchoolBusTracker
//
//  Created by Daniel Phiri on 11/28/17.
//  Copyright © 2017 Cophiri. All rights reserved.
//

import UIKit
import MapKit

class StudentNavigationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager!
    
    var studentName = ""
    
    @IBOutlet weak var studentDistanceStatus: UIView!
    
    @IBOutlet weak var currentAddresOfStudent: UILabel!
    
    @IBAction func navigatePressed(_ sender: UIButton) {
    }
    
    @IBOutlet weak var studentNameLabel: UILabel!
    
    @IBOutlet weak var timeFromStudent: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.studentDistanceStatus.heightAnchor.constraint(equalToConstant: 70.0)
        self.studentDistanceStatus.clipsToBounds = true
        self.studentDistanceStatus.layer.cornerRadius = 4.0
        self.studentDistanceStatus.layer.shadowOpacity = 4.0
        self.studentDistanceStatus.layer.shadowRadius = 4.0
        self.studentDistanceStatus.layer.shadowColor = UIColor.gray.cgColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.studentNameLabel.text = studentName
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
