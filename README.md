# HealthKitSample
This sample project shows how to read/write to HealthKit

iOS Health Kit Authorization View

![hks-01](https://cloud.githubusercontent.com/assets/4623150/8018167/2df05c60-0bd3-11e5-9081-4e34dc29a354.png)

The following view shows a list of measurements. 

![hk-02](https://cloud.githubusercontent.com/assets/4623150/8018168/3010cc14-0bd3-11e5-9b87-ba7db328e0b3.png)

To add more measures modify the following line in `MasterViewController viewDidLoad`:

````
// create quantity types we care about
HKQuantityType *weight = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
HKQuantityType *bloodGlucose = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
HKQuantityType *steps = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];

// request authorization
NSSet *shareTypes = [NSSet setWithObjects:weight, bloodGlucose, steps, nil];

````


The follwoing view shows the data points from HealthKit for the selected measurement. The table view will update automatically in response to a HealthKit update.

![hk-03](https://cloud.githubusercontent.com/assets/4623150/8018169/32cb60a4-0bd3-11e5-80fe-e9234acdde71.png)

This view allows the use to enter a data point into HealthKit for the selected measurement.

![hk-04](https://cloud.githubusercontent.com/assets/4623150/8018170/3678ada6-0bd3-11e5-8ffd-15ede768f6f8.png)
