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
    var name: String!
    var position: String!
    var degree: String!
    var emailAddress: String!
    var webpageAddress: String?
    var officeLocation: String?
    var currentClasses: [Classes]
    var researchInterests: String?
    
    init(name: String, position: String, degree: String, email_address: String, webpage_address: String, office_location: String, current_classes: [Classes], research_interests: String) {
        self.name = name
        self.position = position
        self.degree = degree
        self.emailAddress = email_address
        self.webpageAddress = webpage_address
        self.officeLocation = office_location
        self.currentClasses = current_classes
        self.researchInterests = research_interests
    }
}
