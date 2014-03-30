//
//  SCAbstractGrid_Private.h
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCAbstractGrid.h"

@interface SCAbstractGrid ()

@property (nonatomic, strong) UIScrollView *scrollView;


- (void)resetScrollView;
- (void)addCellWithFrame:(CGRect)frame content:(NSString *)content;

@end
