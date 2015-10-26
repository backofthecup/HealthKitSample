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

    private var objects = [HKQuantityType]()
    private var preferredUnits = [NSObject : AnyObject]()
    private var healthStore = HKHealthStore()
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // health kit types
        let weight = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        let bloodGlucose = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodGlucose)
        
        let healthKitTypes = Set<HKQuantityType>(arrayLiteral: weight!, bloodGlucose!)

        self.healthStore.requestAuthorizationToShareTypes(healthKitTypes as Set, readTypes:healthKitTypes as Set) { (success, error) -> Void in
            if (success) {
                NSLog("HealthKit authorization success...")
                
                self.healthStore.preferredUnitsForQuantityTypes(healthKitTypes as Set, completion: { (preferredUnits, error) -> Void in
                    if (error == nil) {
                        NSLog("...preferred units %@", preferredUnits)
                        self.preferredUnits = preferredUnits
                    }
                })
            }
        }
        
        self.objects = [weight!, bloodGlucose!]
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = self.tableView.indexPathForCell(cell)
        let sampleType = self.objects[indexPath!.row]

        (segue.destinationViewController as! DetailViewController).sampleType = sampleType
        (segue.destinationViewController as! DetailViewController).preferredUnit = self.preferredUnits[sampleType] as! HKUnit
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 

        let object = self.objects[indexPath.row] as HKQuantityType
        cell.textLabel!.text = object.identifier
        return cell
    }

}

