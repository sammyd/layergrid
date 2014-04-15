//
//  SCFrameRateOverlayView.m
//  LayerGrid
//
//  Created by Sam Davies on 01/04/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCFrameRateOverlayView.h"

@interface SCFrameRateOverlayView ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic)

@end

@implementation SCFrameRateOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createLabel];
        self.userInteractionEnabled = NO;
        
        [self start];
    }
    return self;
}

- (void)start
{
    // Create the timer
    self.displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(timerTick:)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stop
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)timerTick:(CADisplayLink *)dl
{
    NSTimeInterval timeSinceLastFrame = CACurrentMediaTime() - self.displayLink.timestamp;
    CGFloat fps = 1 / timeSinceLastFrame;
    self.displayLabel.text = [NSString stringWithFormat:@"%0.2f fps", fps];
}

- (void)removeFromSuperview
{
    // This should remove the retain loop
    [self stop];
    [super removeFromSuperview];
}

#pragma mark - Utility Methods
- (void)createLabel
{
    self.displayLabel = [UILabel new];
    self.displayLabel.textColor = [UIColor greenColor];
    self.displayLabel.backgroundColor = [UIColor redColor];
    self.displayLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.displayLabel.font = [UIFont systemFontOfSize:40.f];
    self.displayLabel.text = @"FRAMERATE";
    [self addSubview:self.displayLabel];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[lbl]-|" options:0 metrics:nil views:@{@"lbl": self.displayLabel}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lbl]-100-|" options:0 metrics:nil views:@{@"lbl": self.displayLabel}]];
    
}

@end
