//
//  DetailViewController.h
//  HealthKitSample
//
//  Created by Eric Mansfield on 6/3/15.
//  Copyright (c) 2015 Eric Mansfield. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKSampleType;

@interface DetailViewController : UITableViewController

@property (strong, nonatomic) HKSampleType *sampleType;

- (IBAction)addTapped:(id)sender;

@end
