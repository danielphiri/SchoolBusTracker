//
//  LogInViewController.swift
//  SchoolBusTracker
//
//  Created by Daniel Phiri on 10/30/17.
//  Copyright © 2017 Cophiri. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var emailFieldConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var emailBottonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordFieldConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var logInHeight: NSLayoutConstraint!
    
    @IBOutlet weak var buttonsHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var passwordBottomConstraint: NSLayoutConstraint!
    
    
    
    var emailAddress: String?
    var password: String?
    
    @IBAction func logInPressed(_ sender: UIButton) {
        guard let emailText = emailText.text else { return }
        guard let passwordText = passwordText.text else { return }
        
        if self.emailText.text == "" || self.passwordText.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Log In Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: emailText, password: passwordText) { (user, error) in
                
                if error == nil {
                    
                    self.performSegue(withIdentifier: segueLogInToMapScreen, sender: self)
                } else {
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Log In Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailText.delegate = self
        self.passwordText.delegate = self
        // Do any additional setup after loading the view.
    }
    

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        self.logoImageView.isHidden = false
//        if textField == self.emailText {
//            self.emailAddress = textField.text
////            self.emailText.frame.origin.y += 200
////
////            self.logoImageView.frame.origin.y += 200
//            self.emailFieldConstraint.constant += 200
//            self.emailBottonConstraint.constant += 200
//            self.logInHeight.constant = 26.5
//            //self.buttonsHeight.constant = 30
//        } else {
////            self.password = textField.text
////            self.logoImageView.frame.origin.y += 200
////            self.passwordText.frame.origin.y += 200
//            self.passwordFieldConstraint.constant += 200
//            self.passwordBottomConstraint.constant += 200
//            self.logInHeight.constant = 26.5
//            //self.buttonsHeight.constant = 30
//        }
//        self.view.reloadInputViews()
//    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == self.emailText {
////            self.emailText.frame.origin.y -= 200
//            self.emailFieldConstraint.constant -= 200
//            self.emailBottonConstraint.constant -= 200
//            self.logInHeight.constant = 26.5
//            //self.buttonsHeight.constant = 30
////            self.logoImageView.isHidden = true
//            self.view.bringSubview(toFront: self.emailText)
////            self.emailText.layer.borderColor = UIColor.gray.cgColor
////            self.emailText.backgroundColor = UIColor.darkGray
////            self.emailText.layer.borderWidth = 1.0
//        } else {
////            self.passwordText.frame.origin.y -= 200
//           self.passwordFieldConstraint.constant -= 200
//            self.passwordBottomConstraint.constant -= 200
//            self.logInHeight.constant = 26.5
//            //self.buttonsHeight.constant = 30
////            self.logoImageView.isHidden = true
////            self.logoImageView.frame.origin.y -= 200
//            self.view.bringSubview(toFront: self.passwordText)
////            self.passwordText.layer.borderColor = UIColor.gray.cgColor
////            self.passwordText.backgroundColor = UIColor.darkGray
////            self.passwordText.layer.borderWidth = 1.0
//        }
//        self.view.reloadInputViews()
//    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
////        self.textDidChange(textField)
//        return true
//    }
    
//    func textDidChange(_ field: UITextField) {
//        if field == self.emailText {
//            self.emailText.frame.origin.y -= 200
//            self.logoImageView.frame.origin.y -= 200
////            self.emailText.layer.borderColor = UIColor.gray.cgColor
////            self.emailText.backgroundColor = UIColor.darkGray
////            self.emailText.layer.borderWidth = 1.0
//        } else {
//            self.passwordText.frame.origin.y -= 200
//            self.logoImageView.frame.origin.y -= 200
////            self.passwordText.layer.borderColor = UIColor.gray.cgColor
////            self.passwordText.backgroundColor = UIColor.darkGray
////            self.passwordText.layer.borderWidth = 1.0
//        }
//    }
   
    
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
