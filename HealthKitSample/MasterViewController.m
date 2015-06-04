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

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HKQuantityType *weight = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *bloodGlucose = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    
    NSSet *shareTypes = [NSSet setWithObjects:weight, bloodGlucose, nil];
    
    self.healthStore = [[HKHealthStore alloc] init];
    [self.healthStore requestAuthorizationToShareTypes:shareTypes readTypes:shareTypes completion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"..HealthKit authorization granted.....");
        }
    }];

    self.objects = @{weight : @"Weight", bloodGlucose : @"Blood Glucose"};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    HKQuantityType *quantityType = self.objects.allKeys[indexPath.row];
    [segue.destinationViewController setValue:quantityType forKey:@"sampleType"];
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
