//
//  SCLayerGrid.h
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

@import UIKit;

@interface SCLayerGrid : UIView

// 2D array of strings to display
@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) CGFloat columnWidth;
@property (nonatomic, assign) CGFloat rowHeight;

@end
