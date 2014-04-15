//
//  SCMovingAverageCalculator.m
//  LayerGrid
//
//  Created by Sam Davies on 15/04/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCMovingAverageCalculator.h"

@interface SCMovingAverageCalculator ()

@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, assign) NSUInteger length;

@end

@implementation SCMovingAverageCalculator

+ (instancetype)calculatorWithLength:(NSUInteger)length
{
    return [[[self class] alloc] initWithLength:length];
}

- (instancetype)initWithLength:(NSUInteger)length
{
    self = [super init];
    if(self) {
        self.values = [NSMutableArray arrayWithCapacity:length];
        self.length = length;
    }
    return self;
}


- (NSNumber *)addValue:(NSNumber *)number
{
    if([self.values count] == self.length) {
        [self.values removeObjectAtIndex:0];
    }
    [self.values addObject:number];
    return [self.values valueForKeyPath:@"@avg.self"];
}

@end
