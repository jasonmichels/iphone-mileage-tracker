//
//  Mileage.m
//  truckMileageTracker
//
//  Created by Jason Michels on 6/10/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import "Mileage.h"

@implementation Mileage
@synthesize fileMileage, showHelpAlert, hasErrors, hasStateError, stateErrorMessage, hasMileageError, mileageErrorMessage, state, mileage, states;

/**
 Load mileage data
 */
-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"mileage.plist"];
}

/**
 Initialize mileage
 */
-(Mileage *)init
{
    self = [super init];
    
    if (self) {
        // Lets load all the mileage from the file
        NSString *filePath = [self dataFilePath];
        
        if( [[NSFileManager defaultManager] fileExistsAtPath:filePath] ){
            self.fileMileage = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
            self.showHelpAlert = NO;
        }else{
            self.fileMileage = [[NSMutableArray alloc] init];
            self.showHelpAlert = YES;
        }
        
        // Pre-load the states object
        self.states = [[States alloc] init];
    }
    
    return self;
}

-(void)showHelperAlert
{
    if (self.showHelpAlert) {
        
        // Since first time using app show the alert message how to run the app
        NSMutableString *message = [[ NSString stringWithFormat:@"%@. \n\n%@", @"Looks like your first time here. To get started enter your current state and current mileage on the next screen.  This will get you setup", @"Next time you come back, enter the state you are entering into and your mileage and let Mileage Plus do the rest"] mutableCopy];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome" message:message delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil, nil];
    
        [alert show];
        
    }
}

-(void) validate
{
    self.hasErrors = NO;
    self.hasStateError = NO;
    self.hasMileageError = NO;
    [self validateState];
    [self validateMileage];
}

-(void)validateState
{
    if (self.state.length == 0) {
        self.hasErrors = YES;
        self.hasStateError = YES;
        self.stateErrorMessage = @"State Cannot Be Empty";
    }
}

-(void)validateMileage
{
    if (self.mileage.length == 0) {
        self.hasErrors = YES;
        self.hasMileageError = YES;
        self.mileageErrorMessage = @"Mileage Cannot Be Empty";
    }
}

-(void) saveRow
{
    // Convert abbreviation into long name
    if (self.state.length == 2) {
        // Loop through states until find a match then set the state picked to the long version
        for (NSUInteger i = 0; i < [self.states.states count]; i++) {
            // Create new dictionary from row in array
            NSDictionary *row = [self.states.states objectAtIndex:i];
            
            if ([self.state.uppercaseString isEqualToString:[row objectForKey:@"abbreviation"]]) {
                self.state = [row objectForKey:@"name"];
            }
        }
    }
    
    // Create a dictionary with an item for each number and state
    NSMutableDictionary *newRow = [NSMutableDictionary new];
    [newRow setObject: self.state forKey: stateKey];
    [newRow setObject:[NSNumber numberWithInt:[self.mileage intValue]] forKey:finalMileageKey];
    
    // Save the date information
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    [newRow setObject: [NSString stringWithFormat:@"%d", [components day]] forKey: @"day"];
    [newRow setObject: [NSString stringWithFormat:@"%d", [components month]] forKey: @"month"];
    [newRow setObject: [NSString stringWithFormat:@"%d", [components year]] forKey: @"year"];
    
    // Add the dictionary to the array before saving to file
    [self.fileMileage addObject:newRow];
    [self.fileMileage writeToFile:[self dataFilePath] atomically:YES];
}

-(void)showConfirmation
{
    // Show save message alert box
    NSMutableString *savedMessage = [[ NSString stringWithFormat:@"Your state of %@ and mileage of %@ have been saved. Select History to view quarterly summary.", self.state, self.mileage] mutableCopy];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"State & Mileage Saved" message:savedMessage delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil, nil];
    
    [alert show];
}

@end
