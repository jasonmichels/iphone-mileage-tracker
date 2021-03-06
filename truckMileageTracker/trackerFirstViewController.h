//
//  trackerFirstViewController.h
//  truckMileageTracker
//
//  Created by Jason Michels on 1/30/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "Mileage.h"

@interface trackerFirstViewController : UIViewController
<ADBannerViewDelegate>
{   
    UITextField *stateField;
    UITextField *mileageField;
    UIButton *selectButton;
    UILabel *stateErrorLabel;
    UILabel *mileageErrorLabel;
    
    ADBannerView *bannerView;
    BOOL *bannerIsVisible;
    
    Mileage *mileage;
}

@property IBOutlet UITextField *stateField;
@property IBOutlet UITextField *mileageField;
@property IBOutlet UIButton *selectButton;
@property IBOutlet UILabel *stateErrorLabel;
@property IBOutlet UILabel *mileageErrorLabel;

@property IBOutlet ADBannerView *bannerView;
@property BOOL *bannerIsVisible;

@property Mileage *mileage;

- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)buttonPressed:(id)sender;

@end
