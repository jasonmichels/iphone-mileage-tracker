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
@synthesize pickerData;
@synthesize stateChosen;

-(IBAction)buttonPressed:(id)sender{
    NSInteger row = [statePicker selectedRowInComponent:0];
    NSString *selected = [pickerData objectAtIndex:row];
    
    self.stateChosen.text = selected;
    
    NSString *title = [[NSString alloc] initWithFormat:@"You selecterd %@!", selected];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"Thank you for choosing." delegate:nil cancelButtonTitle:@"You're Welcome" otherButtonTitles:nil, nil];
    
    statePicker.hidden = true;
    
    [alert show];
}

- (void)viewDidLoad
{
    NSArray *array = [[NSArray  alloc] initWithObjects:@"MN", @"IA", @"NE", nil, nil];
    self.pickerData = array;
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
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerData count];
}

#pragma mark Picker Delegate Methods
-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component{
    return [pickerData objectAtIndex:row];
}

@end
