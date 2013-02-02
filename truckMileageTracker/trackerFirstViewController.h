//
//  trackerFirstViewController.h
//  truckMileageTracker
//
//  Created by Jason Michels on 1/30/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFilename @"data.plist"

@interface trackerFirstViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>{
    UIPickerView *statePicker;
    NSArray *pickerData;
    NSString *state;
    UIPickerView *mileagePicker;
    NSArray *mileageData;
    UILabel *stateLabel;
    UIButton *selectButton;
}

@property (nonatomic, retain) IBOutlet UIPickerView *statePicker;
@property (nonatomic, retain) NSArray *pickerData;
@property (nonatomic, retain) NSString *state;

@property (nonatomic, retain) IBOutlet UIPickerView *mileagePicker;
@property (nonatomic, retain) NSArray *mileageData;

@property (nonatomic, retain) IBOutlet UILabel *stateLabel;
@property (nonatomic, retain) IBOutlet UIButton *selectButton;


- (IBAction)buttonPressed:(id)sender;
- (NSString *)dataFilePath;

@end
