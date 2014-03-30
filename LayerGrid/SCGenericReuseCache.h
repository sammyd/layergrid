//
//  SCGenericReuseCache.h
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

@import Foundation;

@interface SCGenericReuseCache : NSObject

- (instancetype)initWithCreationBlock:(id (^)())creationBlock;

- (id)dequeueObject;
- (void)returnToCache:(id)object;

@end
