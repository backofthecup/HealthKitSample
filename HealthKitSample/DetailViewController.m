//
//  DetailViewController.m
//  HealthKitSample
//
//  Created by Eric Mansfield on 6/3/15.
//  Copyright (c) 2015 Eric Mansfield. All rights reserved.
//

#import "DetailViewController.h"

@import HealthKit;

@interface DetailViewController ()

@property (strong, nonatomic) NSArray *results;
@property (strong, nonatomic) HKHealthStore *healthStore;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

- (void)refreshData;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.healthStore = [[HKHealthStore alloc] init];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"dd MMM yyyy HH:mm:ss";
    [self refreshData];

    // get updates for this quantity type
    HKObserverQuery *query = [[HKObserverQuery alloc] initWithSampleType:self.sampleType predicate:nil updateHandler:^(HKObserverQuery *query, HKObserverQueryCompletionHandler completionHandler,NSError *error) {
         if (!error) {
             [self refreshData];
         }
     }];
    
    [self.healthStore executeQuery:query];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    HKQuantitySample *sample = self.results[indexPath.row];
    double lbs = [sample.quantity doubleValueForUnit:[HKUnit poundUnit]];
    cell.textLabel.text = [NSString stringWithFormat:@"%1.0f", lbs];
    
    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:sample.startDate];
    
    return cell;
}

#pragma mark - IBActions
- (IBAction)addTapped:(id)sender {
    HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:self.sampleType];
    
    if (status != HKAuthorizationStatusSharingAuthorized) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No Access" message:@"You do not have write access to this data. To enable, open the Health app > Sources and enable permissions for this app." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}



#pragma mark - Private methods
- (void)refreshData {
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];

    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:self.sampleType predicate:nil limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        
        if (!error) {
            self.results = results;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
            NSLog(@"Results.....%@", results);
        }
        else {
            NSLog(@"Error... %@", error);
        }
    }];
    
    [self.healthStore executeQuery:query];
   
}




@end
