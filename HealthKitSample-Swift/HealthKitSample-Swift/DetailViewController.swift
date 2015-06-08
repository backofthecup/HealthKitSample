//
//  DetailViewController.swift
//  HealthKitSample-Swift
//
//  Created by Eric Mansfield on 6/8/15.
//  Copyright (c) 2015 Eric Mansfield. All rights reserved.
//

import HealthKit
import UIKit

class DetailViewController: UITableViewController {

    var sampleType : HKQuantityType!
    var preferredUnit: HKUnit!
    
    var results = [HKQuantitySample]()
    var healthStore = HKHealthStore()
    var dateFormatter = NSDateFormatter()
    var numberFormatter = NSNumberFormatter()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        
        self.refreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var quantityType = self.sampleType as HKQuantityType
        (segue.destinationViewController as! AddDataPointViewController).quantityType = quantityType
        (segue.destinationViewController as! AddDataPointViewController).preferredUnit = self.preferredUnit
    }

    
    // MARK: - PrivateMethods
    func refreshData() {
        NSLog("refreshData......")
        
    }

}
