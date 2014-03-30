//
//  SCAbstractGrid.m
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCAbstractGrid.h"
#import "SCAbstractGrid_Private.h"

@implementation SCAbstractGrid

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:self.scrollView];
        
        // Some defaults
        self.rowHeight = 30;
        self.columnWidth = 120;
    }
    return self;
}

- (void)setData:(NSArray *)data
{
    if(data != _data) {
        _data = data;
        [self setNeedsLayout];
    }
}


@end
