//
//  TableViewController.swift
//  CS_Faculty
//
//  Created by Audi Bayron on 4/2/17.
//  Copyright © 2017 Audi Bayron. All rights reserved.
//
/*
 "Available or Not Available during office hours"
 - Should use regex to find certain things inside the string
 - should separate hours, classes
 Initializes each object from the plist and adds them to the table
 Added a search function
 Setting to change how each cell is viewed maybe?
 - current classes, ???
 - position, degree
 - implement a settings tab
 */

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {

    var facultyObjects = [CSFaculty]()
    var facultySearchResults = [CSFaculty]()
    
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        readPList()
        
        // Shows the searched items within the table view
        self.resultSearchController.loadViewIfNeeded()
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload table
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Initializes the facultyObjects array by reading the Property List
    func readPList() {
        if let path = Bundle.main.path(forResource: "CSDirectory", ofType: "plist") {
            if let facultyArray = NSArray(contentsOfFile: path) as? [[String: Any]] {
                for dict in facultyArray {
                    let departmentID = dict["department_ID"] as? String
                    let name = dict["name"] as? String
                    let position = dict["position"] as? String
                    let degree = dict["degree"] as! String
                    let emailAddress = dict["email_address"] as? String
                    let webpageAddress = dict["webpage_address"] as? String
                    let officeLocation = dict["office_location"] as? String
                    let officeHours = dict["office_hours"] as? String
                    let officeRoom = dict["office_room"] as? String
                    let currentClasses = dict["current_classes"] as? String
                    let researchInterests = dict["research_interests"] as? String
                    
                    facultyObjects.append(CSFaculty(department_ID: departmentID!, name: name!, position: position!, degree: degree, email_address: emailAddress!, webpage_address: webpageAddress!, office_location: officeLocation!, office_hours: officeHours!, office_room: officeRoom!, current_classes: currentClasses!, research_interests: researchInterests!))
                } // end for loop
            } // end facultyArray
        } // end path
    }
    
    // MARK: - Availability Functions
    /**
     Determines the availability of each Faculty member
     Takes current time and date and changes based on if they're available or not
     */
    func availability(hours: String) -> String {
        let currentTime = changeHourFormat(time: getCurrentTime())
        let currentDay = getCurrentDay()
        
        //test
        // TODO: - Need to use regex or something similar to separate hours and date
        /**
         Will use this format [Day] [Time Start] - [Time End]
         e.g. Tuesday Thursday 12:30pm - 2:00pm
         ([0-9]*:[0-9]*(?:am|pm))
         */
  
        let ohDay = "Sunday"
        let ohTimeStart = "12:00am"
        let ohTimeEnd = "11:59pm"
        
        let ohTimeStart24 = changeHourFormat(time: ohTimeStart)
        let ohTimeEnd24 = changeHourFormat(time: ohTimeEnd)
        
        // Compares current time and office hours to determine availability
        // If (within military time) && (day is the same)
        if ((ohTimeStart24 < currentTime && ohTimeEnd24 > currentTime) && (currentDay == ohDay)) {
            return "Currently Available"
        }
        
        return "Not Available"
    }
    
    // Takes the Current Time in a hh:mma format
    func getCurrentTime() -> String {
        let d = Date()
        let calendar = Calendar.current
        
        // Looks up current Time
        var hour = calendar.component(.hour, from: d)
        let minutes = calendar.component(.minute, from: d)
        var meridiem: String
        
        // Better Formatting
        if (hour%24 < 12) {
            meridiem = "am"
        } else {
            hour = hour%12
            meridiem = "pm"
        }
        let currentTime = String(format:"%02i:%02i", hour, minutes) + "\(meridiem)"

        return currentTime
    }
    
    // Takes the Current Day
    func getCurrentDay() -> String {
        let calendar = Calendar.current
        
        // Looks up current Date to find current weekday
        let weekday = calendar.component(.weekday, from: Date())
        let currentDay = DateFormatter().weekdaySymbols[weekday-1]
        
        return currentDay
    }
    
    // Turns given String to turn into military time
    func changeHourFormat(time: String) -> Int {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "hh:mma"
        let time12 = dateFormatter.date(from: time)
        dateFormatter.dateFormat = "HHmm"
        let time24 = Int(dateFormatter.string(from: time12!))
        
        return time24!
    }
    
    // MARK: - Search Functions
    //////////////////////////////////////// Search Functions ////////////////////////////////////////
    
    func updateSearchResults(for searchController: UISearchController) {
        filterBySearch(searchText: searchController.searchBar.text!)
    }
    
    func filterBySearch(searchText: String) {
        self.facultySearchResults = facultyObjects.filter { faculty in
            return faculty.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    
    
    // MARK: - Table View Data Source
    ////////////////////////////////////// Table View Functions //////////////////////////////////////
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if (self.resultSearchController.isActive) {
            return self.facultySearchResults.count
        }
        return facultyObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var faculty: CSFaculty
        
        if (self.resultSearchController.isActive) {
            faculty = facultySearchResults[indexPath.row]
            
        } else {
            faculty = facultyObjects[indexPath.row]
        }
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! TableViewCell

        cell.cellNameLbl.text = faculty.name
        cell.cellAvailLbl.text = availability(hours: faculty.officeHours!)
        cell.cellOfficLbl.text = faculty.officeRoom
        
        return cell
    }
    
    // Changes background color for each cell based on its spot on the table
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0) // very light gray
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    // MARK: - Navigation
    ////////////////////////////////////////// Navigation //////////////////////////////////////////

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "DetailView") {
            let destVC = segue.destination as! DetailViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                var faculty: CSFaculty
                if (resultSearchController.isActive && resultSearchController.searchBar.text != "") {
                    faculty = facultySearchResults[indexPath.row]
                    resultSearchController.isActive = false
                } else {
                    faculty = facultyObjects[indexPath.row]
                }
                
                destVC.navigationItem.title = faculty.name
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
            }
        }
    }
}
