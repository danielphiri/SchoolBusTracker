//
//  StudentAccount.swift
//  SchoolBusTracker
//
//  Created by Daniel Phiri on 12/27/17.
//  Copyright © 2017 Cophiri. All rights reserved.
//


import Foundation
import FirebaseAuth
import FirebaseDatabase

class StudentAccount {
    var name: String?
    var homeAddress: Address?
    var schoolName: String?
    var schoolAddress: Address?
    var schoolBusNumber: String?
    var pickUpAddress: Address?
    var studentAccountMade = false
    let dbRef = Database.database().reference()
    let userId = Auth.auth().currentUser?.uid
    
    
    init(name: String) {
        self.name = name
    }
    
    init() {
        
    }
    
    init(name: String, homeAddress: Address, schoolName: String, schoolBusNumber: String, pickUpAddress: Address) {
        self.name = name
        self.addHomeAddress(address: homeAddress)
        self.addSchoolName(name: schoolName)
        self.addSchoolBusNumber(number: schoolBusNumber)
        self.addPickupAddress(address: pickUpAddress)
    }
    
    func addStudentName(name: String) {
        self.name = name
    }
    
    
    func addHomeAddress(address: Address) {
        self.homeAddress = address
    }
    
    func addSchoolName(name: String) {
        self.schoolName = name
    }
    
    func addSchoolBusNumber(number: String) {
        self.schoolBusNumber = number
    }
    
    func addPickupAddress(address: Address) {
        self.pickUpAddress = address
    }
    
    func addSchoolAddress(address: Address) {
        self.schoolAddress = address
    }
    
    func uploadEverythingToFirebase() {
        getLatestChild()
    }
    
    var highestStudent = ""
    
    func getLatestChild() {
        dbRef.child(firAllUserInformation).child(firParents).child(self.userId!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String: Any]
            let firKeys = value?.keys
            if firKeys != nil {
                var ints = [Int]()
                let legibleNums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                for key in firKeys! {
                    let charSet = CharacterSet.decimalDigits
                    var str = ""
                    for char in key.unicodeScalars {
                        if charSet.contains(char) {
                            str = str + char.description
                        }
                    }
                    if str != "" {
                        let charInt = Int(str)
                        ints.append(charInt!)
                    }
                    
                }
                
                if ints.count != 0 {
                    let highestInt = self.getMax(nums: ints) + 1
                    if legibleNums.contains(highestInt) {
                        self.highestStudent = "Student\(highestInt)"
                        self.finishFirebaseUpdate()
                    }
                }
                
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getMax(nums: [Int]) -> Int {
        var big = Int.min
        for num in nums {
            if num > big {
                big = num
            }
        }
        return big
    }
    
    func finishFirebaseUpdate() {
        var currentStudent = highestStudent
        if highestStudent == "" {
            currentStudent = "Student1"
        }
        
        let studentName: [String: String] = [firStudentName: newStudent!.name!]
        dbRef.child(firAllUserInformation).child(firParents).child(userId!).child(currentStudent).updateChildValues(studentName)
        
        let homeAddress: [String: String] = [firCountry: newStudent!.homeAddress!.country, firZip: newStudent!.homeAddress!.zip.description, firState: newStudent!.homeAddress!.state, firCity: newStudent!.homeAddress!.city, firStreet: newStudent!.homeAddress!.street]
        dbRef.child(firAllUserInformation).child(firParents).child(userId!).child(currentStudent).child(firHomeAddress).updateChildValues(homeAddress)
        
        let schoolName: [String: String] = [firSchoolName: (newStudent?.schoolName)!]
        dbRef.child(firAllUserInformation).child(firParents).child(userId!).child(currentStudent).updateChildValues(schoolName)
        let schoolAddress: [String: String] = [firCountry: newStudent!.schoolAddress!.country, firZip: newStudent!.schoolAddress!.zip.description, firState: newStudent!.schoolAddress!.state, firCity: newStudent!.schoolAddress!.city, firStreet: newStudent!.schoolAddress!.street]
        dbRef.child(firAllUserInformation).child(firParents).child(userId!).child(currentStudent).child(firSchoolAddress).updateChildValues(schoolAddress)
        
        
        let numberPlate: [String: String] = [firSchoolBusNumber: (newStudent?.schoolBusNumber)!]
        dbRef.child(firAllUserInformation).child(firParents).child(userId!).child(currentStudent).updateChildValues(numberPlate)
        let pickUpAddress: [String: String] = [firCountry: newStudent!.pickUpAddress!.country, firZip: newStudent!.pickUpAddress!.zip.description, firState: newStudent!.pickUpAddress!.state, firCity: newStudent!.pickUpAddress!.city, firStreet: newStudent!.pickUpAddress!.street]
        dbRef.child(firAllUserInformation).child(firParents).child(userId!).child(currentStudent).child(firPickUpAddress).updateChildValues(pickUpAddress)
        
    }
    
    func pullEverythingFromFirebase() {
        
    }
}
