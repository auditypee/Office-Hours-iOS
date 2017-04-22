//
//  DetailViewController.swift
//  CS_Faculty
//
//  Created by Audi Bayron on 4/6/17.
//  Copyright © 2017 Audi Bayron. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    //destVC.sentData0 = faculty.departmentID
    //destVC.sentData1 = faculty.name
    //destVC.sentData2 = faculty.position
    //destVC.sentData3 = faculty.degree
    //destVC.sentData4 = faculty.emailAddress
    //destVC.sentData5 = faculty.webpageAddress
    //destVC.sentData6 = faculty.officeLocation
    //destVC.sentData7 = faculty.officeHours
    //destVC.sentData8 = faculty.officeRoom
    //destVC.sentData9 = faculty.currentClasses
    //destVC.sentData10 = faculty.researchInterests
    
    var sentData0: String! // Department_ID
    var sentData1: String! // Name
    var sentData2: String! // Position
    var sentData3: String! // Degree
    var sentData4: String! // Email_Address
    var sentData5: String! // Webpage_Address
    var sentData6: String! // Office_Location
    var sentData7: String! // Office_Hours
    var sentData8: String! // Office Room
    var sentData9: String! // Current_Classes
    var sentData10: String! // Research Interests
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
