//
//  WebPageViewController.swift
//  CS_Faculty
//
//  Created by Audi Bayron on 4/23/17.
//  Copyright © 2017 Audi Bayron. All rights reserved.
//
/*******************************************************************************************************
 * Controls the web pages for each professor
 ******************************************************************************************************/
import UIKit

class WebPageViewController: UIViewController {
    var sentData1: String!
    
    @IBOutlet weak var webView: UIWebView!
  
    /**
     * Description - Loads the webView with the given webPageAddress
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = NSURL(string: sentData1!)
        let urlRequest = NSURLRequest(url: myURL! as URL)
        webView.loadRequest(urlRequest as URLRequest)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Bar Button Items
    
    /**
     * Description - Goes to previous page of the webView
     */
    @IBAction func backBtnItemClicked(_ sender: UIBarButtonItem) {
        if (webView.canGoBack) {
            webView.goBack()
        }
    }
    
    /**
     * Description - Goes forward on the webView
     */
    @IBAction func forwardBtnItemClicked(_ sender: UIBarButtonItem) {
        if (webView.canGoForward) {
            webView.goForward()
        }
    }
    
    /**
     * Description - Refreshes the page
     */
    @IBAction func refreshBtnItemClicked(_ sender: UIBarButtonItem) {
        webView.reload()
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
