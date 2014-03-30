//
//  NSIndexSet+SetOperations.h
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

@import Foundation;

@interface NSIndexSet (SetOperations)

- (NSIndexSet *)unionSet:(NSIndexSet *)set;
- (NSIndexSet *)complementSet:(NSIndexSet *)set;
- (NSIndexSet *)intersectionSet:(NSIndexSet *)set;

@end
