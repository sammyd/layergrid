//
//  SCLayerGrid.m
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCLayerGrid.h"
#import "SCAbstractGrid_Private.h"

@implementation SCLayerGrid

- (void)resetScrollView
{
    // Remove any existant cells
    NSArray *sublayers = [self.scrollView.layer.sublayers copy];
    [sublayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperlayer];
    }];
}

- (void)addCellWithFrame:(CGRect)frame content:(NSString *)content
{
    CATextLayer *cell = [CATextLayer layer];
    cell.bounds = CGRectMake(0, 0, self.columnWidth, self.rowHeight);
    cell.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    cell.string = content;
    cell.foregroundColor = [UIColor blackColor].CGColor;
    cell.fontSize = 13;
    cell.contentsScale = [UIScreen mainScreen].scale;
    
    [self.scrollView.layer addSublayer:cell];
}

@end
