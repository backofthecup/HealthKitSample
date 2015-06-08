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

        // update placeholder text
        self.unitsLabel.text = self.preferredUnit.unitString;
        
        self.dataTextField.becomeFirstResponder()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }



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
