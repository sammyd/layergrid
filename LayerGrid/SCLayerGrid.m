//
//  SCLayerGrid.m
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCLayerGrid.h"
#import "SCAbstractGrid_Private.h"

@interface SCLayerGrid ()

@end


@implementation SCLayerGrid

- (void)layoutSubviews
{
    NSLog(@"Layout subviews called");
    // Check we have some suitable data
    if(self.data && [self.data count] > 0 && [self.data[0] count] > 0) {
        NSUInteger numberRows = [self.data count];
        NSUInteger numberCols = [self.data[0] count];
        
        self.scrollView.contentSize = CGSizeMake(numberCols * self.columnWidth,
                                                 numberRows * self.rowHeight);
        
        // Remove any existant cells
        NSArray *sublayers = [self.scrollView.layer.sublayers copy];
        [sublayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperlayer];
        }];
        
        
        // Now add all the cells appropriately
        for(NSUInteger j=0; j<numberRows; j++) {
            for(NSUInteger i=0; i<numberCols; i++) {
                CGRect layerFrame = CGRectMake(i * self.columnWidth, j * self.rowHeight,
                                              self.columnWidth, self.rowHeight);
                CATextLayer *cell = [CATextLayer layer];
                cell.bounds = CGRectMake(0, 0, self.columnWidth, self.rowHeight);
                cell.position = CGPointMake(CGRectGetMidX(layerFrame), CGRectGetMidY(layerFrame));
                cell.string = self.data[j][i];
                cell.foregroundColor = [UIColor blackColor].CGColor;
                cell.fontSize = 13;
                cell.contentsScale = [UIScreen mainScreen].scale;
                
                
                [self.scrollView.layer addSublayer:cell];
            }
        }
    }
}


@end
