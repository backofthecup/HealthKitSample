//
//  MasterViewController.m
//  HealthKitSample
//
//  Created by Eric Mansfield on 6/3/15.
//  Copyright (c) 2015 Eric Mansfield. All rights reserved.
//

#import "MasterViewController.h"

@import HealthKit;

@interface MasterViewController ()

@property HKHealthStore *healthStore;
@property NSDictionary *objects;
@property NSDictionary *preferredUnits;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HKQuantityType *weight = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *bloodGlucose = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    HKQuantityType *steps = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    NSSet *shareTypes = [NSSet setWithObjects:weight, bloodGlucose, steps, nil];
    
    self.healthStore = [[HKHealthStore alloc] init];
    [self.healthStore requestAuthorizationToShareTypes:shareTypes readTypes:shareTypes completion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"..HealthKit authorization granted.....");
        }
    }];
    
    // get the preferred units for the quantity types
    [self.healthStore preferredUnitsForQuantityTypes:shareTypes completion:^(NSDictionary *preferredUnits, NSError *error) {
        NSLog(@"..preferred units.... %@", preferredUnits);
        self.preferredUnits = preferredUnits;
        
    }];

    self.objects = @{weight : @"Weight", bloodGlucose : @"Blood Glucose", steps : @"Steps"};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    HKSampleType *quantityType = self.objects.allKeys[indexPath.row];
    
    UIViewController *viewController = segue.destinationViewController;
    viewController.navigationItem.title = self.objects.allValues[indexPath.row];
    [segue.destinationViewController setValue:quantityType forKey:@"sampleType"];

    // set the preferred unit
    HKUnit *preferredUnit = self.preferredUnits[quantityType];
    [segue.destinationViewController setValue:preferredUnit forKey:@"preferredUnit"];
}


#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *keys = self.objects.allKeys;
    cell.textLabel.text = self.objects[keys[indexPath.row]];
    return cell;
}


@end
