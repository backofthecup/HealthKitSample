//
//  RootViewController.swift
//  HealthKitSample-Swift
//
//  Created by Eric Mansfield on 6/7/15.
//  Copyright (c) 2015 Eric Mansfield. All rights reserved.
//

import UIKit
import HealthKit

class RootViewController: UITableViewController {

    var objects = [HKQuantityType]()
    var preferredUnits = [NSObject : AnyObject]()
    var healthStore: HKHealthStore = HKHealthStore()
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // health kit types
        let weight = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        let bloodGlucose = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodGlucose)
        
        let healthKitTypes = NSSet(array:[weight, bloodGlucose])

        self.healthStore.requestAuthorizationToShareTypes(healthKitTypes as Set, readTypes:healthKitTypes as Set) { (success, error) -> Void in
            if (success) {
                NSLog("HealthKit authorization success...")
                
                self.healthStore.preferredUnitsForQuantityTypes(healthKitTypes as Set, completion: { (units: [NSObject : AnyObject]!, error) -> Void in
                    
                    if (error == nil) {
                        NSLog("...preferred units %@", units)
                        self.preferredUnits = units
                    }
                })
            }
        }
        
        self.objects = [weight, bloodGlucose]
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as HKQuantityType
                
                let sampleType = self.objects[indexPath.row]
                (segue.destinationViewController as! DetailViewController).sampleType = sampleType


            (segue.destinationViewController as! DetailViewController).preferredUnit = self.preferredUnits[sampleType] as! HKUnit
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        let object = objects[indexPath.row] as HKQuantityType
        cell.textLabel!.text = object.identifier
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

