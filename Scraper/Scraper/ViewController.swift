//
//  ViewController.swift
//  Scraper
//
//  Created by Dusty Argyle on 3/2/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        let url: NSURL = NSURL(string: "http://www.nytimes.com")!
        let stringData: NSString? = try! NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        let string: NSString = stringData!
        print("got data: \(string)")
        
        let imageTagRange: NSRange = string.rangeOfString("<img src=\")
        if imageTagRange.location != NSNotFound {
            string = string.substringFromIndex(imageTagRange.location + imageTagRange.length)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

