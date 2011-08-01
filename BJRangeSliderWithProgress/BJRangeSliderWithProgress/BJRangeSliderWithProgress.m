//
//  BJRangeSliderWithProgress.m
//  BJRangeSliderWithProgress
//
//  Created by Barrett Jacobsen on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BJRangeSliderWithProgress.h"

@implementation BJRangeSliderWithProgress
@dynamic minValue, maxValue, currentProgressValue;
@dynamic leftValue, rightValue;
@dynamic showThumbs, showProgress, showRange;

- (void)setLeftValue:(CGFloat)newValue {
    if (newValue < minValue)
        newValue = minValue;
    
    if (newValue > rightValue)
        newValue = rightValue;
    
    leftValue = newValue;
    
    [self setNeedsLayout];
}

- (void)setRightValue:(CGFloat)newValue {
    if (newValue > maxValue)
        newValue = maxValue;
    
    if (newValue < leftValue)
        newValue = leftValue;
    
    rightValue = newValue;
    
    [self setNeedsLayout];
}

- (void)setCurrentProgressValue:(CGFloat)newValue {
    if (newValue > maxValue)
        newValue = maxValue;
    
    if (newValue < minValue)
        newValue = minValue;
    
    currentProgressValue = newValue;
    
    [self setNeedsLayout];
}

- (void)setMinValue:(CGFloat)newValue {
    minValue = newValue;
    
    [self setNeedsLayout];
}

- (void)setMaxValue:(CGFloat)newValue {
    maxValue = newValue;
    
    [self setNeedsLayout];
}

- (CGFloat)minValue {
    return minValue;
}

- (CGFloat)maxValue {
    return maxValue;
}

- (CGFloat)currentProgressValue {
    return currentProgressValue;
}

- (CGFloat)leftValue {
    return leftValue;
}

- (CGFloat)rightValue {
    return rightValue;
}

- (void)setShowThumbs:(BOOL)showThumbs {
    leftThumb.hidden = !showThumbs;
    rightThumb.hidden = !showThumbs;
}

- (BOOL)showThumbs {
    return !leftThumb.hidden;
}


- (void)setShowProgress:(BOOL)showProgress {
    progressImage.hidden = !showProgress;
}

- (BOOL)showProgress {
    return !progressImage.hidden;
}

- (void)setShowRange:(BOOL)showRange {
    rangeImage.hidden = !showRange;
}

- (BOOL)showRange {
    return !rangeImage.hidden;
}

- (void)handleLeftPan:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self];
        CGFloat range = maxValue - minValue;
        CGFloat availableWidth = self.frame.size.width - BJRANGESLIDER_THUMB_SIZE;
        self.leftValue += translation.x / availableWidth * range;
        
        [gesture setTranslation:CGPointZero inView:self];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)handleRightPan:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self];
        CGFloat range = maxValue - minValue;
        CGFloat availableWidth = self.frame.size.width - BJRANGESLIDER_THUMB_SIZE;
        self.rightValue += translation.x / availableWidth * range;
        
        [gesture setTranslation:CGPointZero inView:self];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)setup {
    if (maxValue == 0.0) {
        maxValue = 100.0;
    }
    
    leftValue = minValue;
    rightValue = maxValue;
    
    slider = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"BJRangeSliderEmpty.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:4]];
    [self addSubview:slider];

    rangeImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"BJRangeSliderBlue.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:4]];
    [self addSubview:rangeImage];

    progressImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"BJRangeSliderRed.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:4]];
    [self addSubview:progressImage];

    
    leftThumb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BJRANGESLIDER_THUMB_SIZE, BJRANGESLIDER_THUMB_SIZE)];
    leftThumb.image = [UIImage imageNamed:@"BJRangeSliderStartThumb.png"];
    leftThumb.userInteractionEnabled = YES;
    [self addSubview:leftThumb];
    
    UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftPan:)];
    [leftThumb addGestureRecognizer:leftPan];
    
    rightThumb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BJRANGESLIDER_THUMB_SIZE, BJRANGESLIDER_THUMB_SIZE)];
    rightThumb.image = [UIImage imageNamed:@"BJRangeSliderEndThumb.png"];
    rightThumb.userInteractionEnabled = YES;
    [self addSubview:rightThumb];
    
    UIPanGestureRecognizer *rightPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightPan:)];
    [rightThumb addGestureRecognizer:rightPan];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    
    CGFloat availableWidth = self.frame.size.width - BJRANGESLIDER_THUMB_SIZE;
    CGFloat inset = BJRANGESLIDER_THUMB_SIZE / 2;
    
    CGFloat range = maxValue - minValue;
    
    CGFloat left = floorf((leftValue - minValue) / range * availableWidth);
    CGFloat right = floorf((rightValue - minValue) / range * availableWidth);
    
    slider.frame = CGRectMake(inset, self.frame.size.height / 2 - 5, availableWidth, 10);

    CGFloat rangeWidth = right - left;
    rangeImage.frame = CGRectMake(inset + left, self.frame.size.height / 2 - 5, rangeWidth, 10);
    
    if ([self showProgress]) {
        CGFloat progressWidth = floorf((currentProgressValue - leftValue) / (rightValue - leftValue) * rangeWidth);
        if (isnan(progressWidth)) {
            progressWidth = 0;
        }

        progressImage.frame = CGRectMake(inset + left, self.frame.size.height / 2 - 5, progressWidth, 10);
    }
        
    leftThumb.center = CGPointMake(inset + left, self.frame.size.height / 2 - BJRANGESLIDER_THUMB_SIZE / 2);
    rightThumb.center = CGPointMake(inset + right, self.frame.size.height / 2 + BJRANGESLIDER_THUMB_SIZE / 2);
}


- (void)setDisplayMode:(BJRangeSliderWithProgressDisplayMode)mode {
    switch (mode) {
        case BJRSWPAudioRecordMode:
            self.showThumbs = NO;
            self.showRange = NO;
            self.showProgress = YES;
            progressImage.image = [[UIImage imageNamed:@"BJRangeSliderRed.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:4];
            break;
            
        case BJRSWPAudioSetTrimMode:
            self.showThumbs = YES;
            self.showRange = YES;
            self.showProgress = NO;
            break;

        case BJRSWPAudioPlayMode:
            self.showThumbs = NO;
            self.showRange = YES;
            self.showProgress = YES;
            progressImage.image = [[UIImage imageNamed:@"BJRangeSliderGreen.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:4];
        default:
            break;
    }
}

@end
