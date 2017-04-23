//
//  TableViewController.swift
//  CS_Faculty
//
//  Created by Audi Bayron on 4/2/17.
//  Copyright © 2017 Audi Bayron. All rights reserved.
//
/*
 "Available or Not Available during office hours"
 Initializes each object from the plist and adds them to the table
 Utilizes the searchController to find objects within the tableView
 TODO: - Hide search bar initially
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
                    let departmentID = dict["department_ID"] as! String
                    let name = dict["name"] as! String
                    let position = dict["position"] as! String
                    let degree = dict["degree"] as! String
                    let emailAddress = dict["email_address"] as! String
                    let webpageAddress = dict["webpage_address"] as! String
                    let officeLocation = dict["office_location"] as! String
                    
                    let officeDays = dict["office_days_array"] as! [String]
                    let officeHours = dict["office_hours_array"] as! [String]
                    let officeRooms = dict["office_rooms_array"] as! [String]
                    let currentClasses = dict["current_classes_array"] as! [String]
                    
                    let researchInterests = dict["research_interests"] as! String
                    
                    facultyObjects.append(CSFaculty(department_ID: departmentID, name: name, position: position, degree: degree, email_address: emailAddress, webpage_address: webpageAddress, office_location: officeLocation, office_days_array: officeDays, office_hours_array: officeHours, office_rooms_array: officeRooms, current_classes_array: currentClasses, research_interests: researchInterests))
                    
                } // end for loop
            } // end facultyArray
        } // end path
    }
    
    // MARK: - Availability Functions
    ///////////////////////////////////////////// Availability Functions /////////////////////////////////////////////
    /**
     Determines the availability of each Faculty member
     Takes current time and date and changes based on if they're available or not
     */
    func checkAvailability(hours: [String], days: [String]) -> Bool {
        // All even index are time starts
        var ohTimeStart = [Int]()
        // All odd index are time ends
        var ohTimeEnd = [Int]()
        
        for (index, element) in hours.enumerated() {
            if (index%2 == 0) { // even
                ohTimeStart.append(changeHourFormat(time: element))
            } else { // odd
                ohTimeEnd.append(changeHourFormat(time: element))
            }
        }
        
        // Compares current time and office hours to determine availability
        // If (within military time) && (day is the same)
        return (checkHoursAvailability(timeStart: ohTimeStart, timeEnd: ohTimeEnd)) && (checkDayAvailability(days: days))
    }
    
    // Checks the given array and iterates to check if the current day is the same as one of the available days
    func checkDayAvailability(days: [String]) -> Bool {
        for i in days {
            print("\(i)")
            if (getCurrentDay() == i) {
                return true
            }
        }
        return false
    }
    
    // Checks the given arrays and iterates over them to check if they're within the available time
    func checkHoursAvailability(timeStart: [Int], timeEnd: [Int]) -> Bool {
        let currentTime = getCurrentTime()
        
        for (index, element) in timeStart.enumerated() {
            print("\(element) < \(currentTime) < \(timeEnd[index])")
            if (currentTime > element && currentTime < timeEnd[index]) {
                return true
            }
        }
        return false
    }
    
    // Checks which rooms are used for the specific office hours and returns that room
    func checkRoomAvailability(rooms: [String], days: [String]) -> String {
        // TODO: - implement this
        
        return ""
    }
    
    // Takes the Current Time in a hh:mma format
    func getCurrentTime() -> Int {
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
        let s = String(format:"%02i:%02i", hour, minutes) + "\(meridiem)"
        let currentTime = changeHourFormat(time: s)
        
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
    
    /**
        Updates the Table based on the search results
    */
    func updateSearchResults(for searchController: UISearchController) {
        filterBySearch(searchText: searchController.searchBar.text!)
    }
    
    /**
        Searches by name
    */
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

    /**
        Number of objects within the tableView
    */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if (self.resultSearchController.isActive) {
            return self.facultySearchResults.count
        }
        return facultyObjects.count
    }

    /**
        Changes each cell's attributes
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var faculty: CSFaculty
        var available: String
        
        // For searching
        if (self.resultSearchController.isActive) {
            faculty = facultySearchResults[indexPath.row]
        } else {
            faculty = facultyObjects[indexPath.row]
        }
        
        // For the availability of each professor
        if (checkAvailability(hours: faculty.officeHours, days: faculty.officeDays)) {
            available = "Currently Available"
        } else {
            available = "Not Available"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! TableViewCell

        cell.cellNameLbl.text = faculty.name
        cell.cellAvailLbl.text = available
        //cell.cellOfficLbl.text = faculty.officeRoom
        
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
                destVC.sentData0 = faculty.departmentID
                destVC.sentData1 = faculty.name
                destVC.sentData2 = faculty.position
                destVC.sentData3 = faculty.degree
                destVC.sentData4 = faculty.emailAddress
                destVC.sentData5 = faculty.webpageAddress
                destVC.sentData6 = faculty.officeLocation
                destVC.sentData7 = faculty.officeDays
                destVC.sentData8 = faculty.officeHours
                destVC.sentData9 = faculty.officeRooms
                destVC.sentData10 = faculty.currentClasses
                destVC.sentData11 = faculty.researchInterests
            }
        }
    }
}
