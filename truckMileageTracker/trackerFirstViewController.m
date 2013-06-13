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
@synthesize stateField, mileageField, selectButton, stateErrorLabel, mileageErrorLabel, bannerView, bannerIsVisible, mileage;

/**
 User has clicked button to submit state and mileage
 */
-(IBAction)buttonPressed:(id)sender
{
    // Get state and mileage from textfield
    self.mileage.state = [NSString stringWithFormat:@"%@",self.stateField.text.capitalizedString];
    self.mileage.mileage = [NSString stringWithFormat:@"%@",self.mileageField.text];
    
    // Make sure to hide messages when button clicked
    self.stateErrorLabel.hidden = YES;
    self.mileageErrorLabel.hidden = YES;
    
    // Validation for mileage and state
    [self.mileage validate];
    
    if (self.mileage.hasErrors) {
        
        if (self.mileage.hasStateError) {
            self.stateErrorLabel.text = self.mileage.stateErrorMessage;
            self.stateErrorLabel.hidden = NO;
        }
        
        if (self.mileage.hasMileageError) {
            self.mileageErrorLabel.text = self.mileage.mileageErrorMessage;
            self.mileageErrorLabel.hidden = NO;
        }
        
        return;
    }
    
    // Save new mileage to file
    [self.mileage saveRow];
    
    [self dismissKeyboard: self];
    
    // Show confirmation alert
    [self.mileage showConfirmation];
    
}

/**
 The view did load so run some setup code
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup the iAd banner
    self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    self.bannerView.delegate = self;
    self.bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    self.bannerView.frame = CGRectOffset(self.bannerView.frame, 0, self.view.frame.size.height - self.bannerView.frame.size.height);
    [self.view addSubview:self.bannerView];
    self.bannerIsVisible = nil;
    
    self.mileage = [[Mileage alloc] init];
    [self.mileage showHelperAlert];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Dismiss Keyboard

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
    if (!self.bannerIsVisible) {
        self.bannerIsVisible = YES;
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible) {
        self.bannerIsVisible = NO;
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
    }
}

@end
