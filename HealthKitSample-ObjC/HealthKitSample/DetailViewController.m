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
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;

- (void)refreshData;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.healthStore = [[HKHealthStore alloc] init];
    
    self.numberFormatter = [[NSNumberFormatter alloc] init];
    self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"dd MMM yyyy HH:mm:ss";

    // observe updates for this quantity type
    HKObserverQuery *query = [[HKObserverQuery alloc] initWithSampleType:self.sampleType predicate:nil updateHandler:^(HKObserverQuery *query, HKObserverQueryCompletionHandler completionHandler,NSError *error) {
        if (!error) {
            NSLog(@"Oberserver fire for .... %@", query.sampleType.identifier);
            [self refreshData];
        }
        
        // call if HealthStore.enableBackgroundDelivery is turned on
//        completionHandler();
     }];
    
    [self.healthStore executeQuery:query];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    BOOL performSegue = YES;
    HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:self.sampleType];
    
    if (status != HKAuthorizationStatusSharingAuthorized) {
        performSegue = NO;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No Access" message:@"You do not have write access to this data. To enable, open the Health app > Sources and enable permissions for this app." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    return performSegue;

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HKQuantityType *quantityType = (HKQuantityType *)self.sampleType;
    [segue.destinationViewController setValue:self.preferredUnit forKey:@"preferredUnit"];
    [segue.destinationViewController setValue:quantityType forKey:@"quantityType"];
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
    
    double doubleValue = [sample.quantity doubleValueForUnit:self.preferredUnit];
    NSNumber *number = [NSNumber numberWithDouble:doubleValue];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [self.numberFormatter stringFromNumber:number], self.preferredUnit.unitString];
    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:sample.startDate];
    
    return cell;
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
