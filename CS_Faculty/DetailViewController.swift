//
//  DetailViewController.swift
//  CS_Faculty
//
//  Created by Audi Bayron on 4/6/17.
//  Copyright © 2017 Audi Bayron. All rights reserved.
//
/*******************************************************************************************************
 * Populates the DetailViewController with the professor's information
 * -- webpage button leads to professor's webpage
 * --
 * TODO: - Try out array of labels
 ******************************************************************************************************/
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
    
    @IBOutlet weak var positionTV: UITextView!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var webpageBtnOutlet: UIButton!
    
    @IBOutlet weak var classesTextView: UITextView!
    @IBOutlet weak var officeDaysTextView: UITextView!
    @IBOutlet weak var officeHoursTextView: UITextView!
    
    @IBOutlet weak var emailAddressTextView: UITextView!
    @IBOutlet weak var officeLabel: UILabel!
    @IBOutlet weak var officeLocationLabel: UILabel!

    @IBOutlet weak var researchInterestsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides the webpage button if webpage is not provided
        if (sentData5 == "") {
            webpageBtnOutlet.isEnabled = false
        }
        
        // See loadDate()
        loadData()
    }
    
    /**
     * Description - Loads the data for a given professor. Unpacks the professor's classes into each textView. If retired or has no classes, it leaves each field blank.
     *
     */
    func loadData() {
        positionTV.text = sentData2
        degreeLabel.text = sentData3
        
        webpageBtnOutlet.setTitle(sentData5, for: .normal)
        
        var className = ""
        var officeDays = ""
        var officeHours = ""
        
        for i in sentData7 {
            if (i.className != "No Classes" && i.className != "Retired") {
                className += "\(unpackClassName(cn: i))\n"
                officeDays += "\(unpackOfficeDays(od: i))\n"
                officeHours += "\(unpackOfficeHours(oh: i))"
            }
        }
        
        classesTextView.text = className
        officeDaysTextView.text = officeDays
        officeHoursTextView.text = officeHours
        
        emailAddressTextView.text = sentData4
        if (sentData6 == "") {
            officeLabel.isHidden = true
        }
        officeLocationLabel.text = sentData6
        researchInterestsTextView.text = sentData8
    }
    
    // MARK: - Unpackers
    
    /**
     * Description - Given a professor's class, it returns its name
     *
     * - parameter cn: The professor's class
     *
     * - returns: The class' name
     */
    func unpackClassName(cn: Classes) -> String {
        var unpacked: String
        
        unpacked = cn.className!
        
        return unpacked
    }
    
    /**
     * Description - Given a professor's class, it returns its days for office hours
     *
     * - parameter cn: The professor's class
     *
     * - returns: The class' available days for office hours
     */
    func unpackOfficeDays(od: Classes) -> String {
        var unpacked = ""
        for i in od.officeDays {
            let index = i.index(i.startIndex, offsetBy: 3)
            unpacked += "\(i.substring(to: index)) "

        }
        return unpacked
    }
    
    /**
     * Description - Given a professor's class, it returns its time for office hours
     *
     * - parameter cn: The professor's class
     *
     * - returns: The class' available time for office hours in a hh:mma - hh:mma format
     */
    func unpackOfficeHours(oh: Classes) -> String {
        var unpacked = ""

        for (index, element) in oh.officeHoursStart.enumerated() {
            let ohSE = "\(element) - \(oh.officeHoursEnd[index])\n"
            unpacked += "\(ohSE) "
        }
        
        return unpacked
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "WebPageView") {
            let destVC = segue.destination as! WebPageViewController
            
            destVC.sentData1 = sentData5
        }
    }

}
