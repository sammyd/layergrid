//
//  SCLayerGrid.m
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCViewGrid.h"
#import "SCAbstractGrid_Private.h"

@interface SCViewGrid ()

@end

@implementation SCViewGrid

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
        NSArray *subviews = [self.scrollView.subviews copy];
        [subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperview];
        }];
        
        // Now add all the cells appropriately
        for(NSUInteger j=0; j<numberRows; j++) {
            for(NSUInteger i=0; i<numberCols; i++) {
                CGRect cellFrame = CGRectMake(i * self.columnWidth, j * self.rowHeight,
                                              self.columnWidth, self.rowHeight);
                UITextView *cell = [[UITextView alloc] initWithFrame:cellFrame];
                cell.text = self.data[j][i];
                [self.scrollView addSubview:cell];
            }
        }
    }
}

@end
