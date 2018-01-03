//
//  SignUpViewController.swift
//  SchoolBusTracker
//
//  Created by Daniel Phiri on 10/30/17.
//  Copyright © 2017 Cophiri. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var phonenumberText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var confirmedPasswordText: UITextField!
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        guard let email = emailText.text else { return }
        guard let password = passwordText.text else { return }
        guard let name = nameText.text else { return }
        
        
        if email == "" || password == "" || name == "" || nameText.text == ""
        || passwordText.text == "" || confirmedPasswordText.text == "" {
            let alertController = UIAlertController(title: "Form Error.", message: "Please fill in form completely.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        else {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    currentParent = ParentAccount.init(Name: self.nameText.text!, Email: email, Password: password)
                    let changeReq = user!.createProfileChangeRequest()
                    changeReq.displayName = self.nameText.text! + "."
                    changeReq.commitChanges(completion:
                        { (err) in
                            if let err = err {
                                print(err)
                            } else {
                                currentParent?.updateUserId(uid: (Auth.auth().currentUser?.uid)!)
                                currentParent?.updateFirebase()
                            }
                    })
                    let alertController = UIAlertController(title: "Congratulations!", message: "You have successfully signed up. You will now be redirected to the login screen.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler:
                        {
                            [unowned self] (action) -> Void in
                            self.performSegue(withIdentifier: segueSignUpToLogIn, sender: self)
                    }))
                    self.present(alertController    , animated: true, completion: nil)
                } else if (self.passwordText.text != self.confirmedPasswordText.text) {
                    let alertController = UIAlertController(title: "Verification Error.", message: "The two passwords do not match.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.confirmedPasswordText.textColor = UIColor.red
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Sign Up Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
