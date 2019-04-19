DKTuner
=======
## Requirements
* Xcode 5 or higher
* Apple LLVM compiler
* iOS 7.1 or higher
* ARC

## Builds
[![Build Status](https://travis-ci.org/dursunkoc/DKTuner.svg?branch=master)](https://travis-ci.org/dursunkoc/DKTuner)

## Usage:
import following files
  * DKTuner.h
  * DKTuner.m
  * tunerImage from (Images.xcassets) or any other image you want for tuner.
  
  and in your view controller
  
  * if you want a scalar value tuner;
```objective-c
      DKTuner* sensitivityTuner = [[DKTuner alloc] initWithFrame:CGRectMake(40, 80, 120, 120)
                                                  usingImage:[UIImage imageNamed:@"tunerImage"]
                                            usingDescription:@"percent"
                                             descriptionFont:[UIFont fontWithName:@"Arial" size:10]
                                                    maxValue:99
                                                    minValue:1
                                             backgroundColor:[UIColor blackColor]
                                                   foreColor:UIColor.whiteColor
                                                  objectFont:[UIFont fontWithName:@"Arial" size:30]];
      [self.view addSubview:sensitivityTuner];
```

  * if you want a time tuner;
```objective-c
        DKTuner* timeTuner = [[DKTuner alloc] initWithFrame:CGRectMake(160, 80, 120, 120)
                                             usingImage:[UIImage imageNamed:@"tunerImage"]
                                       usingDescription:@"mins:secs"
                                        descriptionFont:[UIFont fontWithName:@"Arial" size:10]
                                               maxValue:(60*60)-1
                                               minValue:0
                                        backgroundColor:[UIColor colorWithRed:119.0/255.0 green:144.0/255.0 blue:189.0/255 alpha:1]
                                              foreColor:UIColor.redColor
                                             objectFont:[UIFont fontWithName:@"Arial" size:30]
                                                   mode:DKTunerModeTime];
    [self.view addSubview:timeTuner];
```


  * if you want a catalog tuner;
```objective-c
        DKTuner* daysTuner = [[DKTuner alloc] initWithFrame:CGRectMake(40, 200, 240, 240)
                                             usingImage:[UIImage imageNamed:@"tunerImage"]
                                       usingDescription:@"day"
                                        descriptionFont:[UIFont fontWithName:@"Arial" size:16]
                                                 values:@[@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday"]
                                        backgroundColor:[UIColor colorWithRed:126.0/255.0 green:168.0/255.0 blue:19.0/255 alpha:1]
                                              foreColor:UIColor.blackColor
                                             objectFont:[UIFont fontWithName:@"Arial" size:45]];
        [self.view addSubview:daysTuner];
```

<img src="https://cocoacontrols-production.s3.amazonaws.com/uploads/control_image/image/3976/iOS_Simulator_Screen_shot_Jun_13__2014__1.04.37_AM.png" alt="Screenshot" width="320" height="568" />
