//
//  Strings.swift
//  SchoolBusTracker
//
//  Created by Daniel Phiri on 10/30/17.
//  Copyright © 2017 Cophiri. All rights reserved.
//

import Foundation

var currentParent: ParentAccount?
var newStudent: StudentAccount?

// Segues
let segueLogInToMapScreen = "logInToMapScreen"
let segueSignUpToMapScreen = "signUpToMapScreen"
let segueAddressEntryToStudentRegistration = "addressEntryToStudentRegistration"
let segueFrontPageToMain = "frontPageToMain"
let segueStudentRegistrationToMain = "studentRegistrationToMain"
let segueFromStudentRegistrationToAddress = "fromStudentRegistrationToAddress"
let segueMainToStudentTracker = "mainToStudentTracker"
let segueSignUpToLogIn = "signUpToLogIn"

//FOR FIREBASE
let firProfiles = "Profiles"
let firUserIds = "UserIds"
let firUserEmail = "UserEmail"
let firProfilePic = "ProfilePic"
let firBio = "Bio"
let firOnTheMove = "OnTheMove"
let firFrom = "From"
let firTo = "To"
let firWithUser = "withUser"
let firStorageImagesPath = "Images"
let firImagePathNode = "imagePath"
let firName = "NameForUser"
let dataUrl = "https://hitcha-2afbc.firebaseio.com"
let firLatitude = "Latitude"
let firLongitude = "Longitude"
let firJourneyUrl = "TravelUrl"
let firPassWord = "UserPassword"
let firUserID = "UserID"
let firAllUserInformation = "AllUserInformation"
let firParents = "Parents"
let firStudent1 = "Student1"
let firStudent2 = "Student2"
let firStudent3 = "Student3"
let firStudent4 = "Student4"
let firStudent5 = "Student5"
let firStudent6 = "Student6"
let firStudent7 = "Student7"
let firStudent8 = "Student8"
let firStudent9 = "Student9"
let firStudent10 = "Student10"
let firMobileNumber = "Mobile Number"
let firBusinessEmail = "Business Email"
let firFaxNumber = "Fax Number"
let firProductImagePath = "Image Path"
let firAdImagePath = "adImage"
let firFeaturedBusinesses = "Featured Businesses"
let firStudentName = "Student Name"
let firHomeAddress = "Home Address"
let firSchoolName = "School Name"
let firSchoolAddress = "School Address"
let firSchoolBusNumber = "School Bus Number"
let firPickUpAddress = "Pick Up Address"
let firStreet = "Street"
let firCity = "City"
let firState = "State"
let firZip = "Zip"
let firCountry = "Country"
