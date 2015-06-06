//
//  AddDataPointViewController.m
//  HealthKitSample
//
//  Created by Eric Mansfield on 6/4/15.
//  Copyright (c) 2015 Eric Mansfield. All rights reserved.
//

#import "AddDataPointViewController.h"

@import HealthKit;

@interface AddDataPointViewController ()

@property (strong, nonatomic) HKHealthStore *healthStore;

@end

@implementation AddDataPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.healthStore = [[HKHealthStore alloc] init];

    // update placeholder text
    self.dataTextField.placeholder = self.preferredUnit.unitString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveTapped:(id)sender {
    double value = self.dataTextField.text.doubleValue;
    HKQuantity *quantity = [HKQuantity quantityWithUnit:self.preferredUnit doubleValue:value];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *quantitySample = [HKQuantitySample quantitySampleWithType:self.quantityType quantity:quantity startDate:now endDate:now];
    
    [self.healthStore saveObject:quantitySample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured %@.", error);
            abort();
        }
        else {
            NSLog(@"Data saved to HealthKit!!!!.");
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}

- (IBAction)editingChanged:(id)sender {
    self.saveButton.enabled = [self.dataTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0;
}

@end
