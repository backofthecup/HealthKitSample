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
    var healthStore = HKHealthStore()
    

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

    // MARK: - IBActions
    @IBAction func editingChanged(sender: AnyObject) {
        let textField = sender as! UITextField
        let value = textField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        if (value.characters.count > 0) {
            self.saveButton.enabled = true
        }
        else {
            self.saveButton.enabled = false
        }
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        let doubleValue = (self.dataTextField.text! as NSString).doubleValue
        let quantity = HKQuantity(unit: self.preferredUnit, doubleValue: doubleValue)
        
        let date = NSDate()
        
        let quantitySample = HKQuantitySample(type: self.quantityType, quantity: quantity, startDate: date, endDate: date)
        
        
        self.healthStore.saveObject(quantitySample) { (success, error) -> Void in
            if (success) {
                NSLog("Saved to healthkiit.....")
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.navigationController?.popViewControllerAnimated(true)
                })
            }
        }
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        NSLog("Cancel tapped....")
        self.navigationController?.popViewControllerAnimated(true)
    }
}
