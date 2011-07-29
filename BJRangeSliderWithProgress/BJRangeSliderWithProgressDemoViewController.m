//
//  BJRangeSliderWithProgressViewController.m
//  BJRangeSliderWithProgress
//
//  Created by Barrett Jacobsen on 7/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BJRangeSliderWithProgressDemoViewController.h"

@implementation BJRangeSliderWithProgressDemoViewController
@synthesize slider;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSlider:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.slider setDisplayMode:BJRSWPAudioRecordMode];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)recordDemoFire:(NSTimer*)timer {
    self.slider.currentProgressValue += 0.6;
    
    if (self.slider.currentProgressValue >= self.slider.maxValue) {

        [self.slider setDisplayMode:BJRSWPAudioSetTrimMode];

        [timer invalidate];
    }
}

- (IBAction)didPressRecordDemo:(id)sender {
    [self.slider setDisplayMode:BJRSWPAudioRecordMode];
    
    self.slider.currentProgressValue = 0;
    self.slider.leftValue = 0;
    self.slider.rightValue = self.slider.maxValue;
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(recordDemoFire:) userInfo:nil repeats:YES];
}

- (void)playDemoFire:(NSTimer*)timer {
    self.slider.currentProgressValue += 0.2;
    
    if (self.slider.currentProgressValue >= self.slider.rightValue) {
        [self.slider setDisplayMode:BJRSWPAudioSetTrimMode];

        [timer invalidate];
    }
}

- (IBAction)didPressPlayDemo:(id)sender {
    [self.slider setDisplayMode:BJRSWPAudioPlayMode];
    self.slider.currentProgressValue = self.slider.leftValue;
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(playDemoFire:) userInfo:nil repeats:YES];
}


@end
