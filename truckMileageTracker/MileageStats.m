//
//  MileageStats.m
//  truckMileageTracker
//
//  Created by Jason Michels on 2/4/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import "MileageStats.h"

@implementation MileageStats
@synthesize mileages, quarter, year, quarterMonthOne, quarterMonthTwo, quarterMonthThree, finalStats, returnResults;

-(void)setQuarterMonths
{
    if( [self.quarter isEqual: @"1"] ){
        
        self.quarterMonthOne = @"1";
        self.quarterMonthTwo = @"2";
        self.quarterMonthThree = @"3";
        
    }else if ( [self.quarter isEqual: @"2"] ){
        
        self.quarterMonthOne = @"4";
        self.quarterMonthTwo = @"5";
        self.quarterMonthThree = @"6";
        
    }else if ( [self.quarter isEqual: @"3"] ){
        
        self.quarterMonthOne = @"7";
        self.quarterMonthTwo = @"8";
        self.quarterMonthThree = @"9";
        
    }else if ( [self.quarter isEqual: @"4"] ){
        
        self.quarterMonthOne = @"10";
        self.quarterMonthTwo = @"11";
        self.quarterMonthThree = @"12";
    }

}

-(Boolean)isThisQuarter:(NSDictionary *)row
{
    
    if(
       ([[row objectForKey:@"month"] isEqualToString:self.quarterMonthOne]  ||
       [[row objectForKey:@"month"] isEqualToString:self.quarterMonthTwo]  ||
       [[row objectForKey:@"month"] isEqualToString:self.quarterMonthThree]) &&
       [[row objectForKey:@"year"] isEqualToString:self.year]
       ){
        return YES;
    }else{
        return NO;
    }

}

-(NSMutableDictionary *)execute{
    //This is the dictionary that gets returned
    self.returnResults = [NSMutableDictionary new];
    [self.returnResults setObject: [[NSNumber alloc] initWithInt:0] forKey: @"total"];
    
    //This dictionary holds the list of states and their values
    self.finalStats = [NSMutableDictionary new];

    [self setQuarterMonths];
    
    NSInteger mileagesCount = [self.mileages count];
    
    if(mileagesCount > 0){
        
        //then some mileages exist
        for (int i = 0; i < mileagesCount; i++) {
            
            NSDictionary *currentMileage = [self.mileages objectAtIndex:i];
        
            //check if the mileage row ahead exists
            if( (i + 1) < mileagesCount ){
                //the row ahead does exist, now check that the quarter and year match
                NSDictionary *nextMileage = [self.mileages objectAtIndex:i + 1];                
                
                if( [self isThisQuarter:nextMileage]){
                    
                    //get miles of current row
                    NSNumber *currentMiles = [NSNumber numberWithInt:[[currentMileage objectForKey:@"finalMileage"] intValue]];
                    
                    //get mileage of next row
                    NSNumber *nextMiles = [NSNumber numberWithInt:[[nextMileage objectForKey:@"finalMileage"] intValue]];
                    
                    //subtract next miles from current miles
                    NSNumber *miles = [NSNumber numberWithInteger:[nextMiles intValue] - [currentMiles intValue]];
                    
                    //get the total from dictionary and add to it
                    NSNumber *totalMiles = [self.returnResults objectForKey:@"total"];
                    NSNumber *updatedTotalMiles = [NSNumber numberWithInt:([totalMiles intValue] + [miles intValue])];
                    [self.returnResults setValue:updatedTotalMiles forKey:@"total"];
                    
                    
                    //check if state is already in the dictionary
                    if( [self.finalStats objectForKey:[currentMileage objectForKey:@"state"]]){
                        
                        //take current mileage and add to existing mileage for state
                        NSMutableDictionary *oldState = [self.finalStats objectForKey:[currentMileage objectForKey:@"state"]];
                        //get mileage for the state
                        NSNumber *rollingMileage = [oldState valueForKey:@"mileage"];
                        //add old mileage to new mileage to provide updated value
                        NSNumber *updateMiles = [NSNumber numberWithInt:([rollingMileage intValue] + [miles intValue])];
                        //set the updated miles to the state object
                        [oldState setValue:updateMiles forKey:@"mileage"];
                        //add the state object back to the final stats dictionary
                        [self.finalStats setValue:oldState forKey:[currentMileage objectForKey:@"state"]];
                        
                    }else{
                        
                        //the state has not been added yet so create dictionary and added to final states
                        NSMutableDictionary *stateMileage = [NSMutableDictionary new];
                        [stateMileage setObject:[currentMileage objectForKey:@"state"] forKey:[currentMileage objectForKey:@"state"]];
                        [stateMileage setObject:miles forKey:@"mileage"];
                        
                        [self.finalStats setObject:stateMileage forKey:[currentMileage objectForKey:@"state"]];
                    }
                }
            }
        }
        
    }
    
    //add the final stats to the returnResults dictionary
    [self.returnResults setObject:self.finalStats forKey:@"results"];
    
//    NSLog(@"Final stats count %u", [self.finalStats count]);
    

//        for ( id key in self.finalStats) {
//            NSMutableDictionary *row = [self.finalStats objectForKey:key];
//            NSLog(@"%@", row);
//    
//            for ( id test in row) {
//                NSLog(@"Test stuff %@", test);
//            }
//            NSLog(@"--------------------------");
//        }

    return self.returnResults;
}

@end
