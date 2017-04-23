//
//  Classes.swift
//  CS_Faculty
//
//  Created by Audi Bayron on 4/22/17.
//  Copyright © 2017 Audi Bayron. All rights reserved.
//

import UIKit

class Classes: NSObject {
    var className: String!
    var officeDays = [String]()
    var officeHoursStart = [String]()
    var officeHoursEnd = [String]()
    var officeRoom: String!
    
    init(class_name: String, office_days_array: [String], office_hours_start: [String], office_hours_end: [String], office_room: String) {
        self.className = class_name
        self.officeDays = office_days_array
        self.officeHoursStart = office_hours_start
        self.officeHoursEnd = office_hours_end
        self.officeRoom = office_room
    }
}
