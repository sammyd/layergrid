//
//  SCLayerGrid.m
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCViewGrid.h"
#import "SCAbstractGrid_Private.h"

@implementation SCViewGrid

- (void)resetScrollView
{
    // Remove any existant cells
    NSArray *subviews = [self.scrollView.subviews copy];
    [subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}

- (void)addCell:(id)cell withFrame:(CGRect)frame content:(NSString *)content
{
    UILabel *lCell = (UILabel *)cell;
    lCell.frame = frame;
    lCell.text = content;
    [self.scrollView addSubview:lCell];
}

- (void)removeCell:(id)cell
{
    [cell removeFromSuperview];
}

- (id)createNewCell
{
    return [UILabel new];
}

@end
