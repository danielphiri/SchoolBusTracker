//
//  StudentRegistrationViewController.swift
//  SchoolBusTracker
//
//  Created by Daniel Phiri on 11/2/17.
//  Copyright © 2017 Cophiri. All rights reserved.
//

import UIKit

class StudentRegistrationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var studentName: UITextField!
    
    @IBOutlet weak var schoolName: UITextField!
    
    @IBOutlet weak var schoolBusNumber: UITextField!
    
    var addressType = ""
    
    @IBAction func homeAddressPressed(_ sender: UIButton) {
       addressType = "homeAddress"
        self.performSegue(withIdentifier: segueFromStudentRegistrationToAddress, sender: nil)
    }
    
    
    @IBAction func schoolAddressPressed(_ sender: UIButton) {
        addressType = "schoolAddress"
    self.performSegue(withIdentifier: segueFromStudentRegistrationToAddress, sender: nil)
    }
    
    
    @IBAction func pickUpAddressPressed(_ sender: UIButton) {
        
       addressType = "pickUpAddress"
        self.performSegue(withIdentifier: segueFromStudentRegistrationToAddress, sender: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        if currentParent!.addedStudent == nil || (currentParent!.addedStudent?.studentAccountMade)! {
            let alert = UIAlertController(title: "Information Not Saved:", message: "We have not saved your information since you did not finish filling the form. If you navigate away, all of the information you have entered will be lost. Are you sure you want to proceed?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Yes", style: .default, handler: {
                [unowned self] (action) -> Void in
                
                newStudent = nil
                self.infoSaved = false
                self.performSegue(withIdentifier: segueStudentRegistrationToMain, sender: nil)
                
            })
            alert.addAction(action)
            let neutral = UIAlertAction(title: "No", style: .cancel)
            alert.addAction(neutral)
            self.present(alert, animated: true, completion: nil)
        } else if !infoSaved {
            let alert = UIAlertController(title: "Student Information Not Saved:", message: "You've filled in all student information but haven't saved it yet. You will leave all information if you navigate away. Are you sure you want to proceed?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Yes", style: .default, handler: {
                [unowned self] (action) -> Void in
                self.performSegue(withIdentifier: segueStudentRegistrationToMain, sender: nil)
                
            })
            alert.addAction(action)
            let neutral = UIAlertAction(title: "No", style: .cancel)
            alert.addAction(neutral)
            self.present(alert, animated: true, completion: nil)
        }
        
        else {
            let alert = UIAlertController(title: "Congratulations!", message: "Information about your student will now be able to show on the map and you can easily track them on the school bus!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: {
                [unowned self] (action) -> Void in
                
                newStudent = nil
                self.performSegue(withIdentifier: segueStudentRegistrationToMain, sender: nil)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    var infoSaved = false
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if studentName.text == "" || schoolName.text == "" || schoolBusNumber.text == "" || newStudent?.homeAddress == nil || newStudent?.schoolAddress == nil || newStudent?.pickUpAddress == nil {
            let alert = UIAlertController(title: "Incomplete Form:", message: "You have not filled in the form completely. Please do so in order to save your data.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else {
            currentParent?.addedStudent = newStudent
            if currentParent?.students == nil {
                currentParent?.students = [StudentAccount]()
            }
            currentParent?.students?.append(newStudent!)
            newStudent?.uploadEverythingToFirebase()
            let alert = UIAlertController(title: "Success!", message: "Congratulations! We've successfully added \(newStudent!.name!) to your list of Students!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .cancel)
            alert.addAction(action)
            infoSaved = true
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        studentName.delegate = self
        schoolName.delegate = self
        schoolBusNumber.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if newStudent != nil {
            if newStudent?.name != nil {
                self.studentName.text = newStudent?.name
            }
            if newStudent?.schoolName != nil {
                self.schoolName.text = newStudent?.schoolName
            }
            if newStudent?.schoolBusNumber != nil {
                self.schoolBusNumber.text = newStudent?.schoolBusNumber
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if newStudent == nil {
            newStudent = StudentAccount()
        }
        if textField == studentName {
            newStudent?.addStudentName(name: textField.text!)
        } else if textField == schoolName {
            newStudent?.addSchoolName(name: textField.text!)
        } else if textField == schoolBusNumber {
            newStudent?.addSchoolBusNumber(number: textField.text!)
        }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueFromStudentRegistrationToAddress {
            if let dest = segue.destination as? AddressesEntryViewController {
                dest.addressType = addressType
            }
        }
    
    }

}
