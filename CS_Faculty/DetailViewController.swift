//
//  DetailViewController.swift
//  CS_Faculty
//
//  Created by Audi Bayron on 4/6/17.
//  Copyright © 2017 Audi Bayron. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var sentData0: String! // Department_ID
    var sentData1: String! // Name
    var sentData2: String! // Position
    var sentData3: String! // Degree
    var sentData4: String! // Email_Address
    var sentData5: String! // Webpage_Address
    var sentData6: String! // Office_Location
    var sentData7: [Classes]! // Current_Classes -- office hours start, office hours end, office days, office room
    var sentData8: String! // Research Interests
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var webpageLabel: UILabel!
    
    @IBOutlet weak var classesTextView: UITextView!
    @IBOutlet weak var officeHoursTextView: UITextView!
    
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var officeLocationLabel: UILabel!

    
    @IBOutlet weak var researchInterestsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        positionLabel.text = sentData2
        degreeLabel.text = sentData3
        webpageLabel.text = sentData4
        
        var className = ""
        var officeHours = ""
        
        for i in sentData7 {
            className += "\(unpackClassName(cn: i))\n"
            officeHours += "\(unpackOfficeHours(oh: i))\n"
        }
        
        classesTextView.text = className
        officeHoursTextView.text = officeHours
        
        emailAddressLabel.text = sentData4
        officeLocationLabel.text = sentData6
        researchInterestsTextView.text = sentData8
    }
    
    func unpackClassName(cn: Classes) -> String {
        var unpacked: String
        
        unpacked = cn.className!
        
        if (cn.officeHoursStart.count > 1) {
            unpacked += "\n"
        }
        
        return unpacked
    }
    
    func unpackOfficeHours(oh: Classes) -> String {
        var unpacked: String
        
        unpacked = "\(oh.officeRoom!)   "
        
        for i in oh.officeDays {
            let index = i.index(i.startIndex, offsetBy: 3)
            unpacked += "\(i.substring(to: index)) "
        }
        
        for (index, element) in oh.officeHoursStart.enumerated() {
            let ohSE = "\(element) - \(oh.officeHoursEnd[index])"
            
            unpacked += "\(ohSE) "
        }
        
        return unpacked
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
