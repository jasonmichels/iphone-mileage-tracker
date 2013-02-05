//
//  trackerSecondViewController.m
//  truckMileageTracker
//
//  Created by Jason Michels on 1/30/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import "trackerSecondViewController.h"
#import "MileageStats.h"

@interface trackerSecondViewController ()

@end

@implementation trackerSecondViewController
@synthesize fileMileage, table;

-(NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSLog(@"%@", documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

-(IBAction)buttonPressed:(id)sender
{
    //lets load all the mileage from the file
    NSString *filePath = [self dataFilePath];
    
    if( [[NSFileManager defaultManager] fileExistsAtPath:filePath] ){
        fileMileage = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }else{
        fileMileage = [[NSMutableArray alloc] init];
    }
    
    MileageStats *stats = [MileageStats new];
    stats.mileages = self.fileMileage;
    stats.quarter = @"1";
    stats.year = @"2013";
    NSMutableDictionary *finalResults = stats.execute;
    
    //total mileage
    NSString *totalMiles = [finalResults objectForKey:@"total"];
    NSMutableDictionary *stateResults = [finalResults objectForKey:@"results"];
//    NSLog(@"%@", stateResults);
//    NSLog(@"%@", finalResults);
//    NSLog(@"Total Miles: %@", totalMiles);

}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *objects = @[@"Iowa - 200", @"Minnesota - 300", @"Nebraska - 400"];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@", [objects objectAtIndex:indexPath.row]];
    return cell;
}


@end
