//
//  MapViewController.swift
//  SchoolBusTracker
//
//  Created by Daniel Phiri on 10/30/17.
//  Copyright © 2017 Cophiri. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseDatabase

class MapViewController: UIViewController, CLLocationManagerDelegate {
    

    @IBOutlet weak var mainMap: MKMapView!
    
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var addStudent1: UIButton!
    var studentName = ""
    
    
    @IBAction func studentStatusPressed(_ sender: UIButton) {
        if sender.titleLabel != nil && sender.titleLabel?.text != nil {
            studentName = (sender.titleLabel?.text!)!
            self.performSegue(withIdentifier: segueMainToStudentTracker, sender: nil)
        }
    }
    
    @IBOutlet weak var student1: UIButton!
    
    @IBOutlet weak var student2: UIButton!
    
    @IBOutlet weak var student3: UIButton!
    
    @IBOutlet weak var student4: UIButton!
    
    @IBOutlet weak var student5: UIButton!
    
    @IBOutlet weak var student6: UIButton!
    
    @IBOutlet weak var student7: UIButton!
    
    @IBOutlet weak var student8: UIButton!
    
    @IBOutlet weak var student9: UIButton!
    
    @IBOutlet weak var student10: UIButton!
    
    let dbRef = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateStudentNames()
        student1.isHidden = true
        student2.isHidden = true
        student3.isHidden = true
        student4.isHidden = true
        student5.isHidden = true
        student6.isHidden = true
        student7.isHidden = true
        student8.isHidden = true
        student9.isHidden = true
        student10.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    var students = [String: String]()
    
    func updateStudentNames() {
        dbRef.child(firAllUserInformation).child(firParents).child(self.userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String: Any]
            let firKeys = value?.keys
            if firKeys != nil {
                for key in firKeys! {
                    if key.count > 7 {
                        if key.prefix(upTo: String.Index(encodedOffset: 7)) == "Student" {
                            let nameDerivative = value![key] as! [String: Any]
                            self.students[key] = nameDerivative[firStudentName] as? String
                            self.isDoneRunningUpdatUI()
                        }
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func isDoneRunningUpdatUI() {
        if students.keys.contains(firStudent1) {
            self.student1.isHidden = false
            self.student1.setTitle(students[firStudent1], for: .normal)
        }
        if students.keys.contains(firStudent2) {
            self.student2.isHidden = false
            self.student2.setTitle(students[firStudent2], for: .normal)
        }
        if students.keys.contains(firStudent3) {
            self.student3.isHidden = false
            self.student3.setTitle(students[firStudent3], for: .normal)
        }
        if students.keys.contains(firStudent4) {
            self.student4.isHidden = false
            self.student4.setTitle(students[firStudent4], for: .normal)
        }
        if students.keys.contains(firStudent5) {
            self.student5.isHidden = false
            self.student5.setTitle(students[firStudent5], for: .normal)
        }
        if students.keys.contains(firStudent6) {
            self.student6.isHidden = false
            self.student6.setTitle(students[firStudent6], for: .normal)
        }
        if students.keys.contains(firStudent7) {
            self.student7.isHidden = false
            self.student7.setTitle(students[firStudent7], for: .normal)
        }
        if students.keys.contains(firStudent8) {
            self.student8.isHidden = false
            self.student8.setTitle(students[firStudent8], for: .normal)
        }
        if students.keys.contains(firStudent9) {
            self.student9.isHidden = false
            self.student9.setTitle(students[firStudent9], for: .normal)
        }
        if students.keys.contains(firStudent10) {
            self.student10.isHidden = false
            self.student10.setTitle(students[firStudent10], for: .normal)
        }
    }
    
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueMainToStudentTracker {
            if let dest = segue.destination as? StudentNavigationViewController {
                dest.studentName = self.studentName
            }
        }
    }

}
