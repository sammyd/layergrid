//
//  SCAbstractGrid.m
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCAbstractGrid.h"
#import "SCAbstractGrid_Private.h"
#import "NSIndexSet+SetOperations.h"
#import "SCGenericReuseCache.h"

@interface SCAbstractGrid () <UIScrollViewDelegate>

@property (nonatomic, strong) NSIndexSet *visibleRowIndices;
@property (nonatomic, strong) NSIndexSet *visibleColIndices;
@property (nonatomic, strong) SCGenericReuseCache *reuseCache;

@end

@implementation SCAbstractGrid

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        // Some defaults
        self.rowHeight = 30;
        self.columnWidth = 120;
        
        // Reuse cache
        self.reuseCache = [[SCGenericReuseCache alloc] initWithCreationBlock:^id{
            return [self createNewCell];
        }];
    }
    return self;
}

- (void)setData:(NSArray *)data
{
    if(data != _data) {
        _data = data;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"Layout subviews called");
    // Check we have some suitable data
    if(self.data && [self.data count] > 0 && [self.data[0] count] > 0) {
        NSUInteger numberRows = [self.data count];
        NSUInteger numberCols = [self.data[0] count];
        
        self.scrollView.contentSize = CGSizeMake(numberCols * self.columnWidth,
                                                 numberRows * self.rowHeight);
        
        // Prepare the scroll view
        [self resetScrollView];
        
        // Now add all the cells appropriately
        for(NSUInteger j=0; j<numberRows; j++) {
            for(NSUInteger i=0; i<numberCols; i++) {
                CGRect layerFrame = [self frameForCellWithRow:j col:i];
                NSString *content = [NSString stringWithFormat:@"(%d,%d) %@", i, j, self.data[j][i]];
                id cell = [self.reuseCache dequeueObject];
                [self addCell:cell withFrame:layerFrame content:content];
            }
        }
    }
}

#pragma mark - Abstract methods
- (void)resetScrollView __attribute__((__noreturn__))
{
    NSException *exception = [NSException exceptionWithName:@"NotImplemented"
                                                     reason:@"Override this in a subclass"
                                                   userInfo:nil];
    @throw exception;
}

- (void)addCell:(id)cell withFrame:(CGRect)frame content:(NSString *)content __attribute__((__noreturn__))
{
    NSException *exception = [NSException exceptionWithName:@"NotImplemented"
                                                     reason:@"Override this in a subclass"
                                                   userInfo:nil];
    @throw exception;
}

- (void)removeCell:(id)cell __attribute__((__noreturn__))
{
    NSException *exception = [NSException exceptionWithName:@"NotImplemented"
                                                     reason:@"Override this in a subclass"
                                                   userInfo:nil];
    @throw exception;
}

- (id)createNewCell __attribute__((__noreturn__))
{
    NSException *exception = [NSException exceptionWithName:@"NotImplemented"
                                                     reason:@"Override this in a subclass"
                                                   userInfo:nil];
    @throw exception;
}

#pragma mark - Utility methods
- (NSIndexSet *)currentlyVisibleRows
{
    NSUInteger minCell = MAX(floor(CGRectGetMinY(self.scrollView.bounds) / self.rowHeight), 0);
    NSUInteger maxCell = ceil(CGRectGetMaxY(self.scrollView.bounds) / self.rowHeight);
    NSUInteger noCells = maxCell - minCell;
    return [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(minCell, noCells)];
}

- (NSIndexSet *)currentlyVisibleCols
{
    NSUInteger minCell = MAX(floor(CGRectGetMinX(self.scrollView.bounds) / self.columnWidth), 0);
    NSUInteger maxCell = ceil(CGRectGetMaxX(self.scrollView.bounds) / self.columnWidth);
    NSUInteger noCells = maxCell - minCell;
    return [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(minCell, noCells)];
}

- (CGRect)frameForCellWithRow:(NSUInteger)row col:(NSUInteger)col
{
    return CGRectMake(col * self.columnWidth, row * self.rowHeight,
                      self.columnWidth, self.rowHeight);
}

#pragma mark - UISCrollViewDelegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"%@", NSStringFromCGRect(scrollView.bounds));
    
    // Get the new cells
    NSIndexSet *currentRows = [self currentlyVisibleRows];
    NSIndexSet *currentCols = [self currentlyVisibleCols];
    
    // Which are new?
    //NSLog(@"New Rows: %@", [currentRows complementSet:self.visibleRowIndices]);
    NSIndexSet *newCols = [currentCols complementSet:self.visibleColIndices];
    if([newCols count] > 0) {
        NSLog(@"New Cols: %@", newCols);
    }
    
    // And which have disappeared?
    //NSLog(@"Lost Rows: %@", [self.visibleRowIndices complementSet:currentCols]);
    NSIndexSet *lostCols = [self.visibleColIndices complementSet:currentCols];
    if([lostCols count] > 0) {
        NSLog(@"Lost Cols: %@", lostCols);
    }
    
    
    self.visibleColIndices = currentCols;
    self.visibleRowIndices = currentRows;
}


@end
