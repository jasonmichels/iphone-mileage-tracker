//
//  Mileage.h
//  truckMileageTracker
//
//  Created by Jason Michels on 6/10/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "States.h"

#define kFilename @"mileage.plist"
#define stateKey @"state"
#define finalMileageKey @"finalMileage"
//NSString *const kFilename = @"mileage.plist";
//NSString *const stateKey = @"state";
//NSString *const finalMileageKey = @"finalMileage";

@interface Mileage : NSObject
{
    NSMutableArray *fileMileage;
    BOOL *showHelpAlert;
    
    BOOL *hasErrors;
    BOOL *hasStateError;
    NSString *stateErrorMessage;
    BOOL *hasMileageError;
    NSString *mileageErrorMessage;
        
    NSString *state;
    NSString *mileage;
    
    States *states;
}

// This should hold an array of probably dictionary
@property NSMutableArray *fileMileage;
@property BOOL *showHelpAlert;

@property BOOL *hasErrors;
@property BOOL *hasStateError;
@property NSString *stateErrorMessage;
@property BOOL *hasMileageError;
@property NSString *mileageErrorMessage;

@property NSString *state;
@property NSString *mileage;

@property States *states;

-(Mileage *)init;
-(void) showHelperAlert;
-(void) validate;
-(void) saveRow;
-(void) showConfirmation;

@end
