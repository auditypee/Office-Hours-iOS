//
//  TableViewController.swift
//  CS_Faculty
//
//  Created by Audi Bayron on 4/2/17.
//  Copyright © 2017 Audi Bayron. All rights reserved.
//
/******************************************************************************************************
 * "Available or Not Available for office hours"
 * -- table view cell subtext determines whether or not a professor has an office hour at the current time
 * -- see availability functions
 * Initializes each object from the plist and adds them to the table
 * -- added Classes object to store another array of dictionaries inside and array of dictionaries
 * Utilizes the searchController to find objects within the tableView
 * -- stores searched items in a different container to pull from
 * -- uses UISearchResultsUpdating
 * TODO: - Hide search bar initially
 *****************************************************************************************************/

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
    }
    
    /**
     * Description - Initializes the facultyObjects array by reading the Property List
     */
    func readPList() {
        if let path = Bundle.main.path(forResource: "CSDirectory", ofType: "plist") {
            if let facultyArray = NSArray(contentsOfFile: path) as? [[String: Any]] {
                for dict in facultyArray {
                    let name = dict["name"] as! String
                    let position = dict["position"] as! String
                    let degree = dict["degree"] as! String
                    let emailAddress = dict["email_address"] as! String
                    let webpageAddress = dict["webpage_address"] as! String
                    let officeLocation = dict["office_location"] as! String
                    
                    // Initializes the Classes array 
                    var classesObjects = [Classes]()
                    let classesArray = dict["current_classes"] as! [[String: Any?]]
                    for i in classesArray {
                        let className = i["class_name"] as! String
                        let officeDays = i["office_days_array"] as! [String]
                        let officeHoursStart = i["office_hours_start"] as! [String]
                        let officeHoursEnd = i["office_hours_end"] as! [String]
                        
                        classesObjects.append(Classes(class_name: className, office_days_array: officeDays, office_hours_start: officeHoursStart, office_hours_end: officeHoursEnd))
                    }
                    
                    let researchInterests = dict["research_interests"] as! String
                    
                    facultyObjects.append(CSFaculty(name: name, position: position, degree: degree, email_address: emailAddress, webpage_address: webpageAddress, office_location: officeLocation, current_classes: classesObjects, research_interests: researchInterests))
                    
                } // end for loop
            } // end facultyArray
        } // end path
    }
    
    // MARK: - Availability Functions
    
    /**
     * Description - Determines the availability of each Faculty member
     *
     * - parameter start: Office hour's start time array
     * - parameter end: Office hour's end time array
     * - parameter days: Office day array
     *
     * - returns: Determining whether or not the office hour is available for that given class
     */
    func checkAvailability(start: [String], end: [String], days: [String]) -> Bool {
        var ohTimeStart = [Int]()
        var ohTimeEnd = [Int]()
        
        for i in start {
            ohTimeStart.append(changeHourFormat(time: i))
        }
        for i in end {
            ohTimeEnd.append(changeHourFormat(time: i))
        }
        
        // Compares current time and office hours to determine availability
        // If (within military time) && (day is the same)
        return (checkHoursAvailability(timeStart: ohTimeStart, timeEnd: ohTimeEnd)) && (checkDayAvailability(days: days))
    }
    
    /**
     * Description - Checks the given array and iterates to check if the current day is the same as one of the available days
     *
     * - parameter days:
     *
     * - returns:
     */
    func checkDayAvailability(days: [String]) -> Bool {
        for i in days {
            //print("\(i)")
            if (getCurrentDay() == i) {
                return true
            }
        }
        return false
    }
    
    /**
     * Description - Checks the given arrays and iterates over them to check if they're within the available time
     *
     * - parameter timeStart:
     * - parameter timeEnd:
     *
     * - returns:
     */
    func checkHoursAvailability(timeStart: [Int], timeEnd: [Int]) -> Bool {
        let currentTime = getCurrentTime()
        
        for (index, element) in timeStart.enumerated() {
            //print("\(element) < \(currentTime) < \(timeEnd[index])")
            if (currentTime > element && currentTime < timeEnd[index]) {
                return true
            }
        }
        return false
    }
    
    /**
     * Description - Takes the Current Time in hh:mma format
     *
     * - returns: The current time in hh:mma format
     */
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

    /**
     * Description - Takes the Current Day
     *
     * - returns: Current day
     */
    func getCurrentDay() -> String {
        let calendar = Calendar.current
        
        // Looks up current Date to find current weekday
        let weekday = calendar.component(.weekday, from: Date())
        let currentDay = DateFormatter().weekdaySymbols[weekday-1]
        
        return currentDay
    }

    /**
     * Description - Turns given String to turn into military time
     *
     * - parameter time: The current time
     *
     * - returns: Time in format HHmm
     */
    func changeHourFormat(time: String) -> Int {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "hh:mma"
        let time12 = dateFormatter.date(from: time)
        dateFormatter.dateFormat = "HHmm"
        let time24 = Int(dateFormatter.string(from: time12!))
        
        return time24!
    }
    
    // MARK: - Search Functions
    
    /**
     * Updates the Table based on the search results, protocol for UISearchResultsUpdating
     */
    func updateSearchResults(for searchController: UISearchController) {
        filterBySearch(searchText: searchController.searchBar.text!)
    }
    
    /**
     * Description - Searches by professor's name
     *
     * - parameter searchText:
     */
    func filterBySearch(searchText: String) {
        self.facultySearchResults = facultyObjects.filter { faculty in
            return faculty.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    // MARK: - Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /**
     * Number of objects within the tableView
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if (self.resultSearchController.isActive) {
            return self.facultySearchResults.count
        }
        return facultyObjects.count
    }

    /**
     * Changes each cell's attributes (professor's name, availability for office hours)
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var faculty: CSFaculty
        var currentClasses = ""
        
        // So searched objects will show up
        if (self.resultSearchController.isActive) {
            faculty = facultySearchResults[indexPath.row]
        } else {
            faculty = facultyObjects[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! TableViewCell
        
        for i in faculty.currentClasses {
            currentClasses += "\(i.className!)\n"
        }
        
        // When there are no office hours for the professor
        cell.cellNameLbl.text = faculty.name
        cell.cellAvailLbl.text = "No Office Hours at this time"
        cell.cellClassTV.text = "\(currentClasses)"
        
        for i in faculty.currentClasses {
            if (i.className == "No Classes") {
                cell.cellAvailLbl.text = ""
            }
            // When there are office hours for the professor
            // This is assumming the professor does not have two Office Hours scheduled at the same time
            else if (checkAvailability(start: i.officeHoursStart, end: i.officeHoursEnd, days: i.officeDays)) {
                cell.cellAvailLbl.text = "Office Hours available for \(i.className!)"
            }
        }
        
        return cell
    }
    
    // Changes background color for each cell based on its spot on the table
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.0) // very light gray
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    // MARK: - Navigation
    
    /**
     * Sends facultyObjects data to the DetailViewController
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "DetailView") {
            let destVC = segue.destination as! DetailViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                var faculty: CSFaculty
                
                // So searched objects will show up
                if (resultSearchController.isActive && resultSearchController.searchBar.text != "") {
                    faculty = facultySearchResults[indexPath.row]
                    resultSearchController.isActive = false
                } else {
                    faculty = facultyObjects[indexPath.row]
                }
                
                destVC.navigationItem.title = faculty.name
                destVC.sentData1 = faculty.name
                destVC.sentData2 = faculty.position
                destVC.sentData3 = faculty.degree
                destVC.sentData4 = faculty.emailAddress
                destVC.sentData5 = faculty.webpageAddress
                destVC.sentData6 = faculty.officeLocation
                destVC.sentData7 = faculty.currentClasses
                destVC.sentData8 = faculty.researchInterests
            }
        }
    }
}
