//
//  HealthKitSampleTests.m
//  HealthKitSampleTests
//
//  Created by Eric Mansfield on 6/3/15.
//  Copyright (c) 2015 Eric Mansfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface HealthKitSampleTests : XCTestCase

@end

@implementation HealthKitSampleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMasterViewController {
    // This is an example of a functional test case.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITableViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"MasterViewController"];
    
    UITableViewCell *cell = [controller.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    XCTAssertNotNil(cell, @"Table view 'Cell' does not exist");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
