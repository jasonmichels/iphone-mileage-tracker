//
//  trackerFirstViewController.m
//  truckMileageTracker
//
//  Created by Jason Michels on 1/30/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import "trackerFirstViewController.h"

@interface trackerFirstViewController ()

@end

@implementation trackerFirstViewController
@synthesize statePicker;
@synthesize mileagePicker;
@synthesize mileageData;
@synthesize pickerData;
@synthesize statePicked;
@synthesize stateLabel;
@synthesize selectButton;
@synthesize fileMileage;

-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSLog(@"%@", documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

-(IBAction)buttonPressed:(id)sender{
    //This is for the state
    NSInteger stateRow = [statePicker selectedRowInComponent:0];
    self.statePicked = [pickerData objectAtIndex:stateRow];
    
    if( statePicker.hidden == false){
        //the state picker is shown right now so hide it
        self.statePicker.hidden = true;
        self.mileagePicker.hidden = false;
        self.stateLabel.text = self.statePicked;
        self.stateLabel.hidden = false;
        [self.selectButton setTitle:@"Select Mileage" forState:UIControlStateNormal];
        
    }else{

        //create a dictionary with an item for each number and state
        NSMutableDictionary *newRow = [NSMutableDictionary new];
        [newRow setObject: self.statePicked forKey: state];
        [newRow setObject: [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:0]]
                   forKey: mileOne];
        [newRow setObject: [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:1]]
                   forKey: mileTwo];
        [newRow setObject: [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:2]]
                   forKey: mileThree];
        [newRow setObject: [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:3]]
                   forKey: mileFour];
        [newRow setObject: [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:4]]
                   forKey: mileFive];
        [newRow setObject: [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:5]]
                   forKey: mileSix];
        [newRow setObject: [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:6]]
                   forKey: mileSeven];
        
        //save the date information
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
        [newRow setObject: [NSString stringWithFormat:@"%d", [components day]] forKey: @"day"];
        [newRow setObject: [NSString stringWithFormat:@"%d", [components month]] forKey: @"month"];
        [newRow setObject: [NSString stringWithFormat:@"%d", [components year]] forKey: @"year"];
        
        NSMutableString *finalMileageRow = [[NSString stringWithFormat:@"%@%@%@%@%@%@%@",
                                                 [newRow objectForKey:mileOne],
                                                 [newRow objectForKey:mileTwo],
                                                 [newRow objectForKey:mileThree],
                                                 [newRow objectForKey:mileFour],
                                                 [newRow objectForKey:mileFive],
                                                 [newRow objectForKey:mileSix],
                                                 [newRow objectForKey:mileSeven]] mutableCopy];
        
        [newRow setObject:[NSNumber numberWithInt:[finalMileageRow intValue]] forKey:finalMileage];
        
        //add the dictionary to the array before saving to file
        [self.fileMileage addObject:newRow];
        [self.fileMileage writeToFile:[self dataFilePath] atomically:YES];
        
        NSMutableString *savedMessage = [[ NSString stringWithFormat:@"Your state of %@ and mileage of %@ have been saved. Select History to view quarterly summary.", self.statePicked, finalMileageRow] mutableCopy];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"State & Mileage Saved" message:savedMessage delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil, nil];
        
        self.mileagePicker.hidden = true;
        self.statePicker.hidden = false;
        self.stateLabel.hidden = true;
        [self.selectButton setTitle:@"Select State" forState:UIControlStateNormal];
        [alert show];
        
    }
    
}

- (void)viewDidLoad
{
    //lets load all the mileage from the file
    NSString *filePath = [self dataFilePath];
    
    if( [[NSFileManager defaultManager] fileExistsAtPath:filePath] ){
        fileMileage = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }else{
        fileMileage = [[NSMutableArray alloc] init];
    }
    
    //get list of states to show in picker
    NSString *statesPath = [[NSBundle mainBundle] pathForResource:
                      @"states" ofType:@"plist"];
    self.pickerData = [[NSArray alloc] initWithContentsOfFile:statesPath];
    
    //get the count of fileMileages
    NSInteger fileMileageCount = [self.fileMileage count];
    NSString *savedState;
    NSArray *defaultMileageArray;
    
    if(fileMileageCount > 0){
        //now get the last mileage
        NSDictionary *lastMileage = [ fileMileage objectAtIndex:(fileMileageCount - 1)];
        //this savedState will come from database previous choice
        savedState = [lastMileage objectForKey:state];
        
        defaultMileageArray = [[NSArray alloc]
                             initWithObjects:
                                [lastMileage objectForKey:mileOne],
                                [lastMileage objectForKey:mileTwo],
                                [lastMileage objectForKey:mileThree],
                                [lastMileage objectForKey:mileFour],
                                [lastMileage objectForKey:mileFive],
                                [lastMileage objectForKey:mileSix],
                                [lastMileage objectForKey:mileSeven],
                                nil];
        
    }else{
        savedState = defaultState;
        //default array of numbers to show
        defaultMileageArray = [[NSArray alloc]
                                      initWithObjects:zero, zero, zero, zero, zero, zero, zero, nil];
    }
    
    //now find the state in the states array
    NSInteger selectedState = [self.pickerData indexOfObject:savedState];
    //set the state row based on previous selection
    [self.statePicker selectRow:selectedState inComponent:0 animated:YES];
    
    //get array of last saved mileage
    self.mileageData = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    
    for(int i = 0; i < 7; i++) {
        //get the choice from the saved mileage array and get the intValue to set the component row
        [self.mileagePicker selectRow:[[defaultMileageArray objectAtIndex:i] intValue] inComponent:i animated:YES];
    }

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Picker Data Source Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if(pickerView.tag ==1){
        //This is the state picker        
        return 1;
    }else{
        //this is the picker for the numbers
        return 7;
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if(pickerView.tag ==1){
        //This is the state picker
        return [pickerData count];
    }else{
        //this is the picker for the numbers
        return [mileageData count];
    }
    
}

#pragma mark Picker Delegate Methods
-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component{
    
    if(pickerView.tag ==1){
        //This is the state picker
        return [pickerData objectAtIndex:row];
    }else{
        //this is the picker for the numbers
        return [mileageData objectAtIndex:row];
    }
    
}

@end
