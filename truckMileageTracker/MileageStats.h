//
//  MileageStats.h
//  truckMileageTracker
//
//  Created by Jason Michels on 2/4/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MileageStats : NSObject{
    NSArray *mileages;
    NSString *quarter;
    NSString *year;
    NSString *quarterMonthOne;
    NSString *quarterMonthTwo;
    NSString *quarterMonthThree;
    NSMutableDictionary *finalStats;
    NSMutableDictionary *returnResults;
}

@property (nonatomic, retain) NSArray *mileages;
@property (nonatomic, retain) NSString *quarter;
@property (nonatomic, retain) NSString *year;
@property (nonatomic, retain) NSString *quarterMonthOne;
@property (nonatomic, retain) NSString *quarterMonthTwo;
@property (nonatomic, retain) NSString *quarterMonthThree;
@property (nonatomic, retain) NSMutableDictionary *finalStats;
@property (nonatomic, retain) NSMutableDictionary *returnResults;

-(NSMutableDictionary *)execute;
@end
