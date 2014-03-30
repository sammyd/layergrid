//
//  SCGenericReuseCache.m
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCGenericReuseCache.h"

@interface SCGenericReuseCache ()

@property (nonatomic, copy) id(^creationBlock)();
@property (nonatomic, strong) NSMutableSet *cache;

@end

@implementation SCGenericReuseCache

- (instancetype)initWithCreationBlock:(id (^)())creationBlock
{
    self = [super init];
    if(self) {
        self.creationBlock = creationBlock;
        self.cache = [NSMutableSet set];
    }
    return self;
}


#pragma mark - API Methods
- (id)dequeueObject
{
    if([self.cache count] > 0) {
        id object = [self.cache anyObject];
        [self.cache removeObject:object];
        return object;
    } else {
        return self.creationBlock();
    }
}

- (void)returnToCache:(id)object
{
    [self.cache addObject:object];
}


@end
