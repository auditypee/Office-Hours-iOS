//
//  AuthorViewController.swift
//  CS_Faculty
//
//  Created by Audi Bayron on 4/24/17.
//  Copyright © 2017 Audi Bayron. All rights reserved.
//
/*******************************************************************************************************
 * Loads the author's webpage
 ******************************************************************************************************/
import UIKit

class AuthorViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    /**
     * Description - Loads the author's webpage
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Path to author webpage
        let path = Bundle.main.path(forResource: "/Profile/index", ofType: "html")
        let data = NSData(contentsOfFile: path!)!
        let html = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
        
        webView.loadHTMLString(html as! String, baseURL: Bundle.main.bundleURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
