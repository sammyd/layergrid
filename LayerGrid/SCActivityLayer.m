//
//  SCActivityLayer.m
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCActivityLayer.h"

@interface SCActivityLayer ()

@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation SCActivityLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.strokeColor = [UIColor blueColor].CGColor;
        self.lineWidth = 2.0;
        self.lineCap = kCALineCapRound;
        self.fillColor = [UIColor clearColor].CGColor;
        
        self.animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        self.animation.repeatCount = HUGE_VALF;
        self.animation.fromValue = @0;
        self.animation.toValue   = @(2 * M_PI);
        self.animation.duration  = 2;
        [self addAnimation:self.animation forKey:@"rotation"];
    }
    return self;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    CGPoint centre = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    CGFloat radius = MIN(CGRectGetWidth(bounds), CGRectGetHeight(bounds)) / 2.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centre
                                                        radius:radius
                                                    startAngle:0
                                                      endAngle:2 * M_PI / 3
                                                     clockwise:YES];
    self.path = path.CGPath;
}

@end
