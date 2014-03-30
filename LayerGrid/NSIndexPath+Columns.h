//
//  NSIndexPath+Columns.h
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface NSIndexPath (Columns)

@property (nonatomic, readonly) NSUInteger column;

+ (instancetype)indexPathForRow:(NSUInteger)row column:(NSUInteger)column;

@end
