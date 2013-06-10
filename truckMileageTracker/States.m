//
//  States.m
//  truckMileageTracker
//
//  Created by Jason Michels on 6/10/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import "States.h"

@implementation States
@synthesize states;

/**
 Initialize states
*/
-(States *)init
{
    self = [super init];
    
    if (self) {
        // Get states from the plist
        NSString *statesPath = [[NSBundle mainBundle] pathForResource:
                                @"states" ofType:@"plist"];
        self.states = [[NSArray alloc] initWithContentsOfFile:statesPath];
    }
    
    return self;        
}

@end
