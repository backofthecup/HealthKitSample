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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        
        // observe updates for this quantity type
        let query = HKObserverQuery(sampleType: self.sampleType, predicate: nil) { (query, completionHandler, error) -> Void in
            NSLog("HelthKit Oberserver fired.....")
            if (error == nil) {
                self.refreshData()
            }

        }
        
        self.healthStore.executeQuery(query)
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        let sample = self.results[indexPath.row];

        let doubleValue = sample.quantity.doubleValueForUnit(self.preferredUnit)
        NSLog("doubleValue %1.2f", doubleValue)
        
        cell.textLabel!.text = "\(doubleValue) \(self.preferredUnit.unitString)"

        let dateString = self.dateFormatter.stringFromDate(sample.startDate)
        cell.detailTextLabel!.text = dateString

        return cell
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var quantityType = self.sampleType as HKQuantityType
        (segue.destinationViewController as! AddDataPointViewController).quantityType = quantityType
        (segue.destinationViewController as! AddDataPointViewController).preferredUnit = self.preferredUnit
    }

    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        var perform = true
        let status = self.healthStore.authorizationStatusForType(self.sampleType)
        if (status != HKAuthorizationStatus.SharingAuthorized) {
            perform = false

            let alert = UIAlertController(title: "No Access", message: "You do not have write access to this data. To enable, open the Health app > Sources and enable permissions for this app.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        return perform
    }
    
    // MARK: - PrivateMethods
    private func refreshData() {
        NSLog("refreshData......")
        let timeSortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

        var query = HKSampleQuery(sampleType: self.sampleType, predicate: nil, limit: 0,
            sortDescriptors: [timeSortDescriptor]) { (query, objects, error) -> Void in
                
                NSLog("results handler.....")
                if (error == nil) {
                    self.results = objects as! [HKQuantitySample]
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        self.tableView.reloadData()
                    })
                }
        }
        
        self.healthStore.executeQuery(query)
    }

}
