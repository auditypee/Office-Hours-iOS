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
    var officeDays = [String]()
    var officeHours = [String]()
    var officeRooms = [String]()
    
    var currentClasses = [String]()
    var researchInterests: String?
    
    init(department_ID: String, name: String, position: String, degree: String, email_address: String, webpage_address: String, office_location: String, office_days_array: [String], office_hours_array: [String], office_rooms_array: [String], current_classes_array: [String], research_interests: String) {
        self.departmentID = department_ID
        self.name = name
        self.position = position
        self.degree = degree
        self.emailAddress = email_address
        self.webpageAddress = webpage_address
        self.officeLocation = office_location
        self.officeDays = office_days_array
        self.officeHours = office_hours_array
        self.officeRooms = office_rooms_array
        self.currentClasses = current_classes_array
        self.researchInterests = research_interests
    }
}
