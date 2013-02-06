//
//  trackerSecondViewController.h
//  truckMileageTracker
//
//  Created by Jason Michels on 1/30/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#define kFilename @"mileage.plist"

#import <UIKit/UIKit.h>
#define kQuarterComponent 0
#define kYearComponenet 1

@interface trackerSecondViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    NSMutableArray *fileMileage;
    UITableView *table;
    UIPickerView *timePicker;
    NSArray *quarters;
    NSArray *years;
    NSMutableArray *tableResults;
    UIButton *selectButton;
    UILabel *quarterYearLabel;
}

@property (nonatomic, retain) NSMutableArray *fileMileage;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UIPickerView *timePicker;
@property (nonatomic, retain) NSArray *quarters;
@property (nonatomic, retain) NSArray *years;
@property (nonatomic, retain) NSMutableArray *tableResults;
@property (nonatomic, retain) IBOutlet UIButton *selectButton;
@property (nonatomic, retain) IBOutlet UILabel *quarterYearLabel;

- (NSString *)dataFilePath;
- (IBAction)buttonPressed:(id)sender;
@end
