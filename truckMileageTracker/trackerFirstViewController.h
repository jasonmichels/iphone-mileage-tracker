//
//  trackerFirstViewController.h
//  truckMileageTracker
//
//  Created by Jason Michels on 1/30/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface trackerFirstViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>{
    UIPickerView *statePicker;
    NSArray *pickerData;
    UILabel *stateChosen;
}

@property (nonatomic, retain) IBOutlet UIPickerView *statePicker;
@property (nonatomic, retain) NSArray *pickerData;
@property (nonatomic, retain) IBOutlet UILabel *stateChosen;
- (IBAction)buttonPressed:(id)sender;

@end
