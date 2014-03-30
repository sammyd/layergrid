//
//  SCDataFactory.h
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

@import Foundation;

@interface SCDataFactory : NSObject

+ (NSArray *)generateDataWithColumns:(NSUInteger)cols rows:(NSUInteger)rows;

@end
