//
//  CSFaculty.swift
//  CS_Faculty
//
//  Created by Audi Bayron on 4/2/17.
//  Copyright © 2017 Audi Bayron. All rights reserved.
//
/*
 Creates an object that holds the data from the plist
 */
import UIKit

class CSFaculty: NSObject {
    var departmentID: String!
    var name: String!
    var position: String!
    var degree: String!
    var emailAddress: String!
    var webpageAddress: String?
    
    var officeLocation: String?
    var officeHours: String?
    var officeRoom: String?
    
    var currentClasses: String?
    var researchInterests: String?
    
    init(department_ID: String, name: String, position: String, degree: String, email_address: String, webpage_address: String, office_location: String, office_hours: String, office_room: String, current_classes: String, research_interests: String) {
        self.departmentID = department_ID
        self.name = name
        self.position = position
        self.degree = degree
        self.emailAddress = email_address
        self.webpageAddress = webpage_address
        self.officeLocation = office_location
        self.officeHours = office_hours
        self.officeRoom = office_room
        self.currentClasses = current_classes
        self.researchInterests = research_interests
    }
}
