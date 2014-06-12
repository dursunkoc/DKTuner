//
//  DKSampleViewController.m
//  DKTuner
//
//  Created by dursun koc on 6/13/14.
//  Copyright (c) 2014 dursunkoc. All rights reserved.
//

#import "DKSampleViewController.h"
#import "DKTuner.h"

@interface DKSampleViewController ()

@end

@implementation DKSampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
    DKTuner* daysTuner = [[DKTuner alloc] initWithFrame:CGRectMake(40, 200, 240, 240)
                                             usingImage:[UIImage imageNamed:@"tunerImage"]
                                       usingDescription:@"day"
                                        descriptionFont:[UIFont fontWithName:@"Arial" size:16]
                                                 values:@[@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday"]
                                        backgroundColor:[UIColor colorWithRed:126.0/255.0 green:168.0/255.0 blue:19.0/255 alpha:1]
                                              foreColor:UIColor.blackColor
                                             objectFont:[UIFont fontWithName:@"Arial" size:45]];
    [self.view addSubview:daysTuner];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
