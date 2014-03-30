//
//  NSIndexPath+Columns.m
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "NSIndexPath+Columns.h"

@implementation NSIndexPath (Columns)

+ (instancetype)indexPathForRow:(NSUInteger)row column:(NSUInteger)column
{
    return [self indexPathForRow:row inSection:column];
}

- (NSUInteger)column
{
    return self.section;
}

@end
