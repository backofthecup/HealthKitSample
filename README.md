# HealthKitSample
This sample project reads & writes data points to HealthKit. It uses 3 measurements: body mass, blood glucose & step count. On the initial run, the HealthKit authorization view will ask the user for authorization. 


## Screenshots
![hks-01](https://cloud.githubusercontent.com/assets/4623150/8018239/84b4d9a6-0bd6-11e5-8cbc-ec68f3d690b2.png)
![hk-02](https://cloud.githubusercontent.com/assets/4623150/8018241/882006d8-0bd6-11e5-897b-96c0d3fab49b.png)
![hk-03](https://cloud.githubusercontent.com/assets/4623150/8018242/8adebc20-0bd6-11e5-8131-4cc1a2675341.png)
![hk-04](https://cloud.githubusercontent.com/assets/4623150/8018243/8d5eddf4-0bd6-11e5-955c-5bff1d53b263.png)

## Examples


To add more measurements, modify the following lines according in `MasterViewController` `viewDidLoad`:

````
// create quantity types we care about
HKQuantityType *weight = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
HKQuantityType *bloodGlucose = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
HKQuantityType *steps = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];

// request authorization
NSSet *shareTypes = [NSSet setWithObjects:weight, bloodGlucose, steps, nil];

````

