//
//  SCFrameRateOverlayView.h
//  LayerGrid
//
//  Created by Sam Davies on 01/04/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

@import UIKit;

@interface SCFrameRateOverlayView : UIView

@property (nonatomic, strong) UILabel *displayLabel;

- (void)start;
- (void)stop;

@end
