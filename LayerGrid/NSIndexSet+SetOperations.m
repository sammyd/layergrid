//
//  NSIndexSet+SetOperations.m
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "NSIndexSet+SetOperations.h"

@implementation NSIndexSet (SetOperations)

- (NSIndexSet *)unionSet:(NSIndexSet *)set
{
    NSMutableIndexSet *newSet = [[NSMutableIndexSet alloc] initWithIndexSet:self];
    [newSet addIndexes:set];
    return [newSet copy];
}

- (NSIndexSet *)complementSet:(NSIndexSet *)set
{
    NSIndexSet *intersection = [self intersectionSet:set];
    NSMutableIndexSet *newSet = [[NSMutableIndexSet alloc] initWithIndexSet:self];
    [intersection enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [newSet removeIndex:idx];
    }];
    return [newSet copy];
}

- (NSIndexSet *)intersectionSet:(NSIndexSet *)set
{
    NSMutableIndexSet *newSet = [NSMutableIndexSet indexSet];
    [self enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if([set containsIndex:idx]) {
            [newSet addIndex:idx];
        }
    }];
    return [newSet copy];
}

@end
