# HealthKitSample
This sample project reads & writes data points to `HealthKit`. It uses 3 categories: Blood Glucose, Steps & Weight. On the initial run, iOS will ask user to grant read and write access to `HealthKit`.


## Screenshots
![hks-01](https://cloud.githubusercontent.com/assets/4623150/8018239/84b4d9a6-0bd6-11e5-8cbc-ec68f3d690b2.png)
![hk-02](https://cloud.githubusercontent.com/assets/4623150/8018241/882006d8-0bd6-11e5-897b-96c0d3fab49b.png)

---

![hk-03](https://cloud.githubusercontent.com/assets/4623150/8018242/8adebc20-0bd6-11e5-8131-4cc1a2675341.png)
![hk-04](https://cloud.githubusercontent.com/assets/4623150/8018243/8d5eddf4-0bd6-11e5-955c-5bff1d53b263.png)


## Examples

To add more categories, modify the following lines accordingly in `MasterViewController` `viewDidLoad`:

````
// create quantity types we care about
HKQuantityType *weight = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
HKQuantityType *bloodGlucose = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
HKQuantityType *steps = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];

// authorization types
NSSet *shareTypes = [NSSet setWithObjects:weight, bloodGlucose, steps, nil];

````

