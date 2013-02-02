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
@synthesize state;
@synthesize stateLabel;
@synthesize selectButton;

-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

-(IBAction)buttonPressed:(id)sender{
    //This is for the state
    NSInteger stateRow = [statePicker selectedRowInComponent:0];
    self.state = [pickerData objectAtIndex:stateRow];
    
    //this is for the mileage
    NSString *mileageOne = [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:0]];
    NSString *mileageTwo = [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:1]];
    NSString *mileageThree = [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:2]];
    NSString *mileageFour = [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:3]];
    NSString *mileageFive = [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:4]];
    NSString *mileageSix = [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:5]];
    NSString *mileageSeven = [mileageData objectAtIndex:[mileagePicker selectedRowInComponent:6]];
    
    NSMutableString *finalMileage = [[NSString stringWithFormat:@"%@%@%@%@%@%@%@", mileageOne, mileageTwo, mileageThree, mileageFour, mileageFive, mileageSix, mileageSeven] mutableCopy];
    
//    NSLog(@"%i", [finalMileage intValue]);
    
    if( statePicker.hidden == false){
        
        //alert = [[UIAlertView alloc] initWithTitle:self.state message:@"State You Chose." delegate:nil cancelButtonTitle:@"You're Welcome" otherButtonTitles:nil, nil];
        
        self.statePicker.hidden = true;
        self.mileagePicker.hidden = false;
        self.stateLabel.text = self.state;
        self.stateLabel.hidden = false;
        [self.selectButton setTitle:@"Select Mileage" forState:UIControlStateNormal];
        
    }else{
        //save info to the database then show a message
        
        NSMutableString *savedMessage = [[ NSString stringWithFormat:@"Your state of %@ and mileage of %@ have been saved.", self.state, finalMileage] mutableCopy];

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
    //get list of states to show in picker
    NSArray *states = [[NSArray  alloc] initWithObjects:@"Alaska", @"Alabama", @"Minnesota", @"Iowa", @"Nebraska", @"Texas", @"South Dakota", nil, nil];
    self.pickerData = states;
    
    //this savedState will come from database previous choice
    NSString *savedState = @"Iowa";
    //now find the state in the states array
    NSInteger selectedState = [states indexOfObject:savedState];
    //set the state row based on previous selection
    [self.statePicker selectRow:selectedState inComponent:0 animated:YES];
    
    //get array of last saved mileage
    NSArray *mileageArray = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    self.mileageData = mileageArray;
    
    //this info will need to come from database
    NSArray *savedMileageArray = [[NSArray alloc]
                                  initWithObjects:@"0", @"8", @"5", @"9", @"2", @"3", @"1", nil];
    
    for(int i = 0; i < 7; i++) {
        //get the choice from the saved mileage array and get the intValue to set the component row
        [self.mileagePicker selectRow:[[savedMileageArray objectAtIndex:i] intValue] inComponent:i animated:YES];
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
