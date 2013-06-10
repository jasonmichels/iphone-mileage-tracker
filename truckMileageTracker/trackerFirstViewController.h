//
//  trackerFirstViewController.h
//  truckMileageTracker
//
//  Created by Jason Michels on 1/30/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

NSString *const kFilename = @"mileage.plist";
NSString *const stateKey = @"state";
NSString *const finalMileageKey = @"finalMileage";

@interface trackerFirstViewController : UIViewController
<ADBannerViewDelegate>
{
    NSMutableArray *fileMileage;    
    UITextField *stateField;
    UITextField *mileageField;
    UIButton *selectButton;
    NSString *state;
    NSString *mileage;
    NSArray *states;
    UILabel *stateErrorLabel;
    UILabel *mileageErrorLabel;
    
    ADBannerView *bannerView;
    BOOL *bannerIsVisible;
}

@property IBOutlet UITextField *stateField;
@property IBOutlet UITextField *mileageField;
@property IBOutlet UIButton *selectButton;
@property IBOutlet UILabel *stateErrorLabel;
@property IBOutlet UILabel *mileageErrorLabel;
@property IBOutlet ADBannerView *bannerView;
@property NSString *state;
@property NSString *mileage;
@property NSArray *states;
@property BOOL *bannerIsVisible;
// This should hold an array of probably dictionary
@property (nonatomic, retain) NSMutableArray *fileMileage;

- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)buttonPressed:(id)sender;
- (NSString *)dataFilePath;

@end
