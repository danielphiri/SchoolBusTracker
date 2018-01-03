//
//  UserAccount.swift
//  SchoolBusTracker
//
//  Created by Daniel Phiri on 12/25/17.
//  Copyright © 2017 Cophiri. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class ParentAccount {
    var name = ""
    var email = ""
    var userName = ""
    var passWord = ""
    var userId: String?
    var userBusinessId: String?
    var profilePic: UIImage?
    var students: [StudentAccount]?
    var addedStudent: StudentAccount?
    let dbRef = Database.database().reference()
    
    
    init(userID: String) {
        updateUserId(uid: userID)
    }
    
    init(Name: String, Email: String, Password: String) {
        name = Name
        email = Email
        passWord = Password
        if let id = Auth.auth().currentUser?.uid {
            self.updateUserId(uid: id)
        }
    }
    
    
    func updateEmail(newPassword: String) {
        let properties: [String: String] = [firPassWord: newPassword]
        dbRef.child(firAllUserInformation).child(firParents).child(userId!).updateChildValues(properties)
    }
    
    func updateProfilePic(imagePath: String) {
        
    }
    
    
    func updateUserId(uid: String) {
        userId = uid
        
    }
    
    
    func autoFillInfo() {
        dbRef.child(firAllUserInformation).child(firParents).child(self.userId!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String: String]
            if value != nil {
                //for key in (value?.keys)! {
                //if let user1 = value?[key] as! [String: String]? {
                for userKey in (value?.keys)! {
                    if userKey == firName {
                        self.name = value![userKey]!
                    } else if userKey == firUserEmail {
                        self.email = value![userKey]!
                    } else if userKey == firPassWord {
                        self.passWord = value![userKey]!
                    } else if userKey == firUserID {
                        self.userId = value![firUserID]!
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    
    //For removing periods and spaces in a string.
    func flaten(st: String?) -> String {
        var s = ""
        if let r = st {
            for k in r.characters {
                if k != "." && k != " " {
                    s = s + k.description
                }
            }
        }
        return s
    }
    
   
    
    func updateFirebase() {
        let properties: [String: String] = [firName: self.name, firUserEmail: self.email, firPassWord: self.passWord]
        dbRef.child(firAllUserInformation).child(firParents).child(userId!).updateChildValues(properties)
        if userId != nil {
            let prop: [String: String] = [firUserID: self.userId!]
            let usnam: [String: String] = [userId!: userName]
            dbRef.child(firAllUserInformation).child(firParents).child(userId!).updateChildValues(prop)
        }
    }
    
    
    
}
