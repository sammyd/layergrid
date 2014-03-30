//
//  SCDataFactory.m
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCDataFactory.h"

@implementation SCDataFactory


+ (NSArray *)generateDataWithColumns:(NSUInteger)cols rows:(NSUInteger)rows
{
    NSArray *wordList = [self wordList];
    
    NSMutableArray *rowArray = [NSMutableArray array];
    for (NSUInteger j = 0; j < rows; j++) {
        NSMutableArray *currentCol = [NSMutableArray array];
        for(NSUInteger i=0; i < cols; i++) {
            [currentCol addObject:wordList[arc4random_uniform([wordList count])]];
        }
        [rowArray addObject:[currentCol copy]];
    }
    return [rowArray copy];
}


+ (NSArray *)wordList
{
    return @[@"Lorem", @"ipsum", @"dolor", @"sit", @"amet", @"consectetur", @"adipiscing", @"elit", @"Quisque", @"ornare", @"elit", @"ac", @"ultricies", @"tempus", @"augue", @"tellus", @"gravida", @"enim", @"ut", @"consectetur", @"nunc", @"risus", @"ut", @"nulla", @"Sed", @"sapien", @"lectus", @"pretium", @"vitae", @"aliquet", @"eget", @"suscipit", @"vitae", @"lorem", @"Pellentesque", @"non", @"aliquam", @"lectus", @"iaculis", @"tristique", @"ante", @"Mauris", @"imperdiet", @"blandit", @"purus", @"eget", @"mollis", @"orci", @"Maecenas", @"eget", @"eros", @"faucibus", @"tincidunt", @"leo", @"vitae", @"pretium", @"lacus", @"Aliquam", @"tristique", @"sapien", @"id", @"dignissim", @"dignissim", @"elit", @"eros", @"aliquam", @"arcu", @"ut", @"cursus", @"quam", @"lorem", @"ac", @"quam", @"Mauris", @"commodo", @"nec", @"nibh", @"id", @"elementum", @"In", @"malesuada", @"nisi", @"at", @"nisl", @"condimentum", @"mollis", @"molestie", @"nibh", @"ultricies", @"Vestibulum", @"luctus", @"ligula", @"in", @"aliquam", @"lobortis", @"velit", @"libero", @"congue", @"sem", @"in", @"luctus", @"lacus", @"sem", @"nec", @"diam", @"Fusce", @"accumsan", @"auctor", @"euismod", @"Maecenas", @"aliquet", @"molestie", @"rhoncus", @"Quisque", @"facilisis", @"neque", @"a", @"euismod", @"fringilla", @"Maecenas", @"imperdiet", @"pulvinar", @"elit", @"auctor", @"suscipit"];

}

@end
