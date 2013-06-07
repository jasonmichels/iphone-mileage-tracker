//
//  trackerFirstViewController.h
//  truckMileageTracker
//
//  Created by Jason Michels on 1/30/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFilename @"mileage.plist"
#define state @"state"
#define finalMileage @"finalMileage"
#define defaultState @"Nebraska"
#define zero @"0"

@interface trackerFirstViewController : UIViewController
{
    NSArray *mileageData;
    NSMutableArray *fileMileage;
    
    UITextField *stateField;
    UITextField *mileageField;
    UIButton *selectButton;
    NSString *statePicked;
    NSString *mileage;
    NSArray *states;
}

@property IBOutlet UITextField *stateField;
@property IBOutlet UITextField *mileageField;
@property IBOutlet UIButton *selectButton;
@property NSString *statePicked;
@property NSString *mileage;
@property NSArray *states;







@property (nonatomic, retain) NSArray *mileageData;
//this should hold an array of probably dictionary
@property (nonatomic, retain) NSMutableArray *fileMileage;


- (IBAction)buttonPressed:(id)sender;
- (NSString *)dataFilePath;

@end
