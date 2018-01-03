//
//  AddressesEntryViewController.swift
//  SchoolBusTracker
//
//  Created by Daniel Phiri on 11/2/17.
//  Copyright © 2017 Cophiri. All rights reserved.
//

import UIKit

class AddressesEntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var countryField: UITextField!
    
    @IBOutlet weak var zipcodeField: UITextField!
    
    @IBOutlet weak var stateField: UITextField!
    
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var streetField: UITextField!
    
    var addressType = ""
    
    var newAddress: Address?
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        if newAddress == nil {
            let alert = UIAlertController(title: "Information Not Saved:", message: "We have not saved your information since you did not finish filling the address form. Are you sure you want to go back?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Yes", style: .default, handler: {
                [unowned self] (action) -> Void in
                
                self.performSegue(withIdentifier: segueAddressEntryToStudentRegistration, sender: nil)
                
            })
            alert.addAction(action)
            let neutral = UIAlertAction(title: "No", style: .cancel)
            alert.addAction(neutral)
            self.present(alert, animated: true, completion: nil)
        } else {
            newAddress = nil
            self.performSegue(withIdentifier: segueAddressEntryToStudentRegistration, sender: nil)
        }
        
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if countryField.text == "" && zipcodeField.text == ""
            && stateField.text == "" && cityField.text == "" && streetField.text == "" {
            let alert = UIAlertController(title: "Empty Form:", message: "You cannot save an address with all empty entries. Please fill in the form completely to save the address.", preferredStyle: .alert)
            let action = UIAlertAction.init(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else if countryField.text == "" || zipcodeField.text == ""
            || stateField.text == "" || cityField.text == "" || streetField.text == "" {
            let alert = UIAlertController(title: "Missing Fields:", message: "Your form contains missing fields. All fields are required. Please make sure that you fill the form in completely.", preferredStyle: .alert)
            let action = UIAlertAction.init(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else {
            if !legalZip(zip: zipcodeField.text!) {
                let alert = UIAlertController(title: "Incorrect Zip Code:", message: "Your zip code is not valid. Please enter a valid 5-digit zip code with no special characters or spaces.", preferredStyle: .alert)
                let action = UIAlertAction.init(title: "Okay", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else {
                let zipInt = Int(zipcodeField.text!)
                newAddress = Address(country: countryField.text!, zip: zipInt!, state: stateField.text!, city: cityField.text!, street: streetField.text!)
                if addressType == "homeAddress" {
                    newStudent?.addHomeAddress(address: newAddress!)
                    let alert = UIAlertController(title: "Success!", message: "The home address for this student has been saved. Please finish entering the other information for the student in order to not lose your progress.", preferredStyle: .alert)
                    let action = UIAlertAction.init(title: "Okay", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                } else if addressType == "schoolAddress" {
                    newStudent?.addSchoolAddress(address: newAddress!)
                    let alert = UIAlertController(title: "Success!", message: "The school address for this student has been saved. Please finish entering the other information for the student in order to not lose your progress.", preferredStyle: .alert)
                    let action = UIAlertAction.init(title: "Okay", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    newStudent?.addPickupAddress(address: newAddress!)
                    let alert = UIAlertController(title: "Success!", message: "The pick-up and drop-off address for this student has been saved. Please finish entering the other information for the student in order to not lose your progress.", preferredStyle: .alert)
                    let action = UIAlertAction.init(title: "Okay", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func legalZip(zip: String) -> Bool {
        if zip.count != 5 {
            return false
        } else if !isDigitsOnly(number: zip) {
            return false
        } else {
            return true
        }
    }
    
    func isDigitsOnly(number: String) -> Bool {
        let digits = NSCharacterSet.decimalDigits
        for char in number.unicodeScalars {
            if !digits.contains(char)  {
                return false
            }
        }
        return true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        countryField.delegate = self
        zipcodeField.delegate = self
        stateField.delegate = self
        cityField.delegate = self
        streetField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if newStudent == nil {
            newStudent = StudentAccount()
        }
        if addressType == "homeAddress" && newStudent?.homeAddress != nil {
            self.countryField.text = newStudent?.homeAddress?.country
            self.zipcodeField.text = newStudent?.homeAddress?.zip.description
            self.stateField.text = newStudent?.homeAddress?.state
            self.cityField.text = newStudent?.homeAddress?.city
            self.streetField.text = newStudent?.homeAddress?.street
            newAddress = newStudent?.homeAddress
        } else if addressType == "schoolAddress" && newStudent?.schoolAddress != nil {
            self.countryField.text = newStudent?.schoolAddress?.country
            self.zipcodeField.text = newStudent?.schoolAddress?.zip.description
            self.stateField.text = newStudent?.schoolAddress?.state
            self.cityField.text = newStudent?.schoolAddress?.city
            self.streetField.text = newStudent?.schoolAddress?.street
            newAddress = newStudent?.schoolAddress
        } else if addressType == "pickUpAddress" && newStudent?.pickUpAddress != nil {
            self.countryField.text = newStudent?.pickUpAddress?.country
            self.zipcodeField.text = newStudent?.pickUpAddress?.zip.description
            self.stateField.text = newStudent?.pickUpAddress?.state
            self.cityField.text = newStudent?.pickUpAddress?.city
            self.streetField.text = newStudent?.pickUpAddress?.street
            newAddress = newStudent?.pickUpAddress
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
