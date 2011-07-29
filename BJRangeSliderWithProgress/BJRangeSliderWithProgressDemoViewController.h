//
//  BJRangeSliderWithProgressViewController.h
//  BJRangeSliderWithProgress
//
//  Created by Barrett Jacobsen on 7/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BJRangeSliderWithProgress.h"


@interface BJRangeSliderWithProgressDemoViewController : UIViewController {
    BJRangeSliderWithProgress *slider;
    
}

@property (strong, nonatomic) IBOutlet BJRangeSliderWithProgress *slider;

- (IBAction)didPressRecordDemo:(id)sender;
- (IBAction)didPressPlayDemo:(id)sender;

@end
