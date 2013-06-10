//
//  States.h
//  truckMileageTracker
//
//  Created by Jason Michels on 6/10/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface States : NSObject
{
    NSArray *states;
}

@property NSArray *states;

-(States*) init;

@end
