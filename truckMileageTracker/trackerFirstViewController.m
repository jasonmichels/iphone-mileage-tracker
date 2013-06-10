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
@synthesize stateField, mileageField, mileage, states, stateErrorLabel, mileageErrorLabel, bannerView, bannerIsVisible;
@synthesize mileageData;
@synthesize statePicked;
@synthesize selectButton;
@synthesize fileMileage;

-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

-(IBAction)buttonPressed:(id)sender
{
    bool *hasErrors = NO;
    self.stateErrorLabel.hidden = true;
    self.mileageErrorLabel.hidden = true;
    
    // Get state and mileage from textfield
    self.statePicked = [NSString stringWithFormat:@"%@",self.stateField.text.capitalizedString];
    NSLog(@"Original state picked, %@", self.statePicked);
    
    self.mileage = [NSString stringWithFormat:@"%@",self.mileageField.text];
    NSLog(@"Original mileage, %@", self.mileage);
    
    // @todo add validation for mileage and state
    if (self.statePicked.length == 0) {
        self.stateErrorLabel.text = @"State cannot be empty";
        self.stateErrorLabel.hidden = false;
        hasErrors = YES;
    }
    
    if (self.mileage.length == 0) {
        self.mileageErrorLabel.text = @"Mileage cannot be empty";
        self.mileageErrorLabel.hidden = false;
        hasErrors = YES;
    }
    
    if (hasErrors) {
        return;
    }
    
    // convert abbreviation into long name
    if (self.statePicked.length == 2) {
        // Loop through states until find a match then set the state picked to the long version
        for (NSUInteger i = 0; i < [self.states count]; i++) {
            // Create new dictionary from row in array
            NSDictionary *row = [self.states objectAtIndex:i];
            
            if ([self.statePicked.uppercaseString isEqualToString:[row objectForKey:@"abbreviation"]]) {
                self.statePicked = [row objectForKey:@"name"];
            }
        }
    }
    
    //create a dictionary with an item for each number and state
    NSMutableDictionary *newRow = [NSMutableDictionary new];
    [newRow setObject: self.statePicked forKey: state];
    [newRow setObject:[NSNumber numberWithInt:[self.mileage intValue]] forKey:finalMileage];
    
    //save the date information
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    [newRow setObject: [NSString stringWithFormat:@"%d", [components day]] forKey: @"day"];
    [newRow setObject: [NSString stringWithFormat:@"%d", [components month]] forKey: @"month"];
    [newRow setObject: [NSString stringWithFormat:@"%d", [components year]] forKey: @"year"];
    
    //add the dictionary to the array before saving to file
    [self.fileMileage addObject:newRow];
    [self.fileMileage writeToFile:[self dataFilePath] atomically:YES];
    
    [self dismissKeyboard: self];
    
    NSMutableString *savedMessage = [[ NSString stringWithFormat:@"Your state of %@ and mileage of %@ have been saved. Select History to view quarterly summary.", self.statePicked, self.mileage] mutableCopy];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"State & Mileage Saved" message:savedMessage delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil, nil];
    
    [alert show];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    self.bannerView.delegate = self;
    self.bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    self.bannerIsVisible = nil;
    
    //lets load all the mileage from the file
    NSString *filePath = [self dataFilePath];
    
    if( [[NSFileManager defaultManager] fileExistsAtPath:filePath] ){
        fileMileage = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }else{
        // @todo Since no file exists show the message how to use this app
        fileMileage = [[NSMutableArray alloc] init];
        
        NSMutableString *message = [[ NSString stringWithFormat:@"%@. \n\n%@", @"Looks like your first time here. To get started enter your current state and current mileage on the next screen.  This will get you setup", @"Next time you come back, enter the state you are entering into and your mileage and let Mileage Plus do the rest"] mutableCopy];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome" message:message delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil, nil];
        
        [alert show];        
    }
    
    //get the count of fileMileages
    NSInteger fileMileageCount = [self.fileMileage count];
    NSString *savedMileage;
    
    if(fileMileageCount > 0){
        //now get the last mileage
        NSDictionary *lastMileage = [ fileMileage objectAtIndex:(fileMileageCount - 1)];
        //this savedState will come from database previous choice
        savedMileage = [lastMileage objectForKey:finalMileage];
        
    }else{
        savedMileage = @"0";
    }
    
    //get list of states to show in picker
    NSString *statesPath = [[NSBundle mainBundle] pathForResource:
                            @"states" ofType:@"plist"];
    self.states = [[NSArray alloc] initWithContentsOfFile:statesPath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.stateField resignFirstResponder];
    [self.mileageField resignFirstResponder];
}

#pragma mark ADBannerViewDelegate

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible)
    {
        self.bannerIsVisible = YES;
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible)
    {
        self.bannerIsVisible = NO;
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
    }
}

@end
