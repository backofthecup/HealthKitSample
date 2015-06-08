//
//  AddDataPointViewController.swift
//  HealthKitSample-Swift
//
//  Created by Eric Mansfield on 6/8/15.
//  Copyright (c) 2015 Eric Mansfield. All rights reserved.
//

import HealthKit
import UIKit

class AddDataPointViewController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var dataTextField: UITextField!
    
    var quantityType: HKQuantityType!
    var preferredUnit: HKUnit!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */




    // MARK: - IBActions
    @IBAction func editingChanged(sender: AnyObject) {
        var textField = sender as! UITextField
        if (textField.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) {
            
            self.saveButton.enabled = true
            
        }
        else {
            self.saveButton.enabled = false
        }
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        NSLog("Cancel tapped....")
        self.navigationController?.popViewControllerAnimated(true)
    }
}
