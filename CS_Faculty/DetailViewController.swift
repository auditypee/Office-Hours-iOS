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
    var sentData7: [String]! // Office_Days
    var sentData8: [String]! // Office_Hours
    var sentData9: [String]! // Office Room
    var sentData10: [String]! // Current_Classes
    var sentData11: String! // Research Interests
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var webpageLabel: UILabel!
    
    
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
