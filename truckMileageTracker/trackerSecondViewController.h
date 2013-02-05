//
//  trackerSecondViewController.h
//  truckMileageTracker
//
//  Created by Jason Michels on 1/30/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#define kFilename @"mileage.plist"

#import <UIKit/UIKit.h>

@interface trackerSecondViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *fileMileage;
    UITableView *table;
}

@property (nonatomic, retain) NSMutableArray *fileMileage;
@property (nonatomic, retain) IBOutlet UITableView *table;

- (NSString *)dataFilePath;
- (IBAction)buttonPressed:(id)sender;
@end
