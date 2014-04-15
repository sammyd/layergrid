//
//  SCMovingAverageCalculator.h
//  LayerGrid
//
//  Created by Sam Davies on 15/04/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

@import Foundation;

@interface SCMovingAverageCalculator : NSObject

+ (instancetype)calculatorWithLength:(NSUInteger)length;

- (instancetype)initWithLength:(NSUInteger) length;
- (NSNumber *)addValue:(NSNumber *)number;

@end
