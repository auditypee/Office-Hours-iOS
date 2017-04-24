//
//  DetailViewController.swift
//  CS_Faculty
//
//  Created by Audi Bayron on 4/6/17.
//  Copyright © 2017 Audi Bayron. All rights reserved.
//
/*
 * TODO: - Documentation
 *
 */
import UIKit

class DetailViewController: UIViewController {
    // MARK: - Data from TableViewCell
    
    var sentData1: String! // Name
    var sentData2: String! // Position
    var sentData3: String! // Degree
    var sentData4: String! // Email_Address
    var sentData5: String! // Webpage_Address
    var sentData6: String! // Office_Location
    var sentData7: [Classes]! // Current_Classes -- office hours start, office hours end, office days
    var sentData8: String! // Research Interests
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var webpageBtnOutlet: UIButton!
    
    @IBOutlet weak var classesTextView: UITextView!
    @IBOutlet weak var officeHoursTextView: UITextView!
    @IBOutlet weak var officeRoomDaysTextView: UITextView!
    
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var officeLabel: UILabel!
    @IBOutlet weak var officeLocationLabel: UILabel!

    @IBOutlet weak var researchInterestsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (sentData5 == "") {
            webpageBtnOutlet.isEnabled = false
        }
        
        loadData()
    }
    
    func loadData() {
        positionLabel.text = sentData2
        degreeLabel.text = sentData3
        

        webpageBtnOutlet.setTitle(sentData5, for: .normal)
        
        var className = ""
        var officeDays = ""
        var officeHours = ""
        
        for i in sentData7 {
            if (i.className != "No Classes") {
                className += "\(unpackClassName(cn: i))\n"
                officeDays += "\(unpackOfficeDays(od: i))\n"
                officeHours += "\(unpackOfficeHours(oh: i))\n"
            }
        }
        
        classesTextView.text = className
        officeRoomDaysTextView.text = officeDays
        officeHoursTextView.text = officeHours
        
        emailAddressLabel.text = sentData4
        if (sentData6 == "") {
            officeLabel.isHidden = true
        }
        officeLocationLabel.text = sentData6
        researchInterestsTextView.text = sentData8
    }
    
    // MARK: - Unpackers
    
    func unpackClassName(cn: Classes) -> String {
        var unpacked: String
        
        unpacked = cn.className!
        
        if (cn.officeHoursStart.count > 1) {
            unpacked += "\n"
        }
        
        return unpacked
    }
    
    func unpackOfficeDays(od: Classes) -> String {
        var unpacked = ""
        for i in od.officeDays {
            let index = i.index(i.startIndex, offsetBy: 3)
            unpacked += "\(i.substring(to: index)) "

        }
    
        if (od.officeHoursStart.count > 1) {
            unpacked += "\n"
        }
        
        return unpacked
    }
    
    func unpackOfficeHours(oh: Classes) -> String {
        var unpacked = ""

        for (index, element) in oh.officeHoursStart.enumerated() {
            let ohSE = "\(element) - \(oh.officeHoursEnd[index])"
            unpacked += "\(ohSE) "
        }
        
        return unpacked
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "WebPageView") {
            let destVC = segue.destination as! WebPageViewController
            
            destVC.navigationItem.title = "Web Page"
            destVC.sentData1 = sentData5
        }

    }
}
