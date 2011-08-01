//
//  BJRangeSliderWithProgress.h
//  BJRangeSliderWithProgress
//
//  Created by Barrett Jacobsen on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BJRSWPAudioRecordMode = 0,
    BJRSWPAudioSetTrimMode,
    BJRSWPAudioPlayMode,

} BJRangeSliderWithProgressDisplayMode;

#define BJRANGESLIDER_THUMB_SIZE 32.0

@interface BJRangeSliderWithProgress : UIControl {

    UIImageView *slider;
    UIImageView *progressImage;
    UIImageView *rangeImage;
    
    UIImageView *leftThumb;
    UIImageView *rightThumb;
    
    CGFloat minValue;
    CGFloat maxValue;
    CGFloat currentProgressValue;
    
    CGFloat leftValue;
    CGFloat rightValue;
}

@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, assign) CGFloat currentProgressValue;

@property (nonatomic, assign) CGFloat leftValue;
@property (nonatomic, assign) CGFloat rightValue;

@property (nonatomic, assign) BOOL showThumbs;
@property (nonatomic, assign) BOOL showProgress;
@property (nonatomic, assign) BOOL showRange;

- (void)setDisplayMode:(BJRangeSliderWithProgressDisplayMode)mode;

@end
