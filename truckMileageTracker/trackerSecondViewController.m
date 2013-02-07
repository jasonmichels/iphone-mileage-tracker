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
@synthesize fileMileage, table, timePicker, quarters, years, tableResults, selectButton, quarterYearLabel;

-(NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSLog(@"%@", documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

-(IBAction)buttonPressed:(id)sender
{
    
    if( self.table.hidden == true ){
        
        //get the quarter and state from the picker
        NSInteger quarterRow = [timePicker selectedRowInComponent:kQuarterComponent];
        NSInteger yearRow = [timePicker selectedRowInComponent:kYearComponenet];
        
        NSString *quarter;
        NSString *tmpQuarter = [self.quarters objectAtIndex:quarterRow];
        
        if( tmpQuarter == @"1st Quarter" ){
            quarter = @"1";
        }else if ( tmpQuarter == @"2nd Quarter"){
            quarter = @"2";
        }else if ( tmpQuarter == @"3rd Quarter"){
            quarter = @"3";
        }else{
            quarter = @"4";
        }

        NSString *year = [self.years objectAtIndex:yearRow];
        
        //lets load all the mileage from the file
        NSString *filePath = [self dataFilePath];
        
        if( [[NSFileManager defaultManager] fileExistsAtPath:filePath] ){
            fileMileage = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        }else{
            fileMileage = [[NSMutableArray alloc] init];
        }
        
        MileageStats *stats = [MileageStats new];
        stats.mileages = self.fileMileage;
        stats.quarter = quarter;
        stats.year = year;
        NSMutableDictionary *finalResults = stats.execute;
        
        //total mileage
        NSString *totalMiles = [finalResults objectForKey:@"total"];
        NSMutableDictionary *stateResults = [finalResults objectForKey:@"results"];
        //    NSLog(@"Total Miles: %@", totalMiles);
        
        self.tableResults = [NSMutableArray new];
        
        for ( id key in stateResults) {
            NSMutableDictionary *row = [stateResults objectForKey:key];
            
            NSString *state;
            NSNumber *mileage;
            
            for ( id rowKey in row) {
                
                if(rowKey != @"mileage"){
                    state = rowKey;
                }else{
                    mileage = [row objectForKey:@"mileage"];
                }
                
            }
            
            NSString *rowString = [[NSString alloc] initWithFormat:@"%@ - %@", state, mileage];
            
            [self.tableResults addObject:rowString];
        }
    
        [self.table reloadData];
        [self.selectButton setTitle:@"Refresh" forState:UIControlStateNormal];
        self.timePicker.hidden = true;
        self.table.hidden = false;
        self.quarterYearLabel.text = [[NSString alloc] initWithFormat:@"Results: %@ miles in Q%@ - %@", totalMiles, quarter, year];
        self.quarterYearLabel.hidden = false;
        
        
    }else{
        //hide the table and show the time picker
        [self.selectButton setTitle:@"Show Statistics" forState:UIControlStateNormal];
        self.timePicker.hidden = false;
        self.table.hidden = true;
        self.quarterYearLabel.hidden = true;
        
    }
    

}

- (void)viewDidLoad
{
    self.quarters = [[NSArray alloc] initWithObjects:@"1st Quarter", @"2nd Quarter", @"3rd Quarter", @"4th Quarter", nil];
    self.years = [[NSArray alloc] initWithObjects:@"2013", @"2014", @"2015", @"2016", @"2017", @"2018", @"2019", @"2020", @"2021", @"2022", @"2023", @"2024", @"2025", nil];

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
    return self.tableResults.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.tableResults objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark -
#pragma mark Picker Data Source Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if(component == kQuarterComponent){
        return [self.quarters count];
    }else{
        return [self.years count];
    }
    
}

#pragma mark Picker Delegate Methods
-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component{
    
    if(component == kQuarterComponent){
        return [self.quarters objectAtIndex:row];
    }else{
        return [self.years objectAtIndex:row];
    }
    
}


@end
