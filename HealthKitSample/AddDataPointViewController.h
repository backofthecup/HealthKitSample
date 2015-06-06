//
//  AddDataPointViewController.h
//  HealthKitSample
//
//  Created by Eric Mansfield on 6/4/15.
//  Copyright (c) 2015 Eric Mansfield. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKQuantityType, HKUnit;

@interface AddDataPointViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (strong, nonatomic) IBOutlet UITextField *dataTextField;
@property (strong, nonatomic) IBOutlet UILabel *unitsLabel;
@property (strong, nonatomic) HKQuantityType *quantityType;
@property (strong, nonatomic) HKUnit *preferredUnit;

- (IBAction)cancelTapped:(id)sender;
- (IBAction)saveTapped:(id)sender;
- (IBAction)editingChanged:(id)sender;

@end
