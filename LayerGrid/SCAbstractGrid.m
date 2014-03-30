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
#import "NSIndexPath+Columns.h"

@interface SCAbstractGrid () <UIScrollViewDelegate>

@property (nonatomic, strong) NSIndexSet *visibleRowIndices;
@property (nonatomic, strong) NSIndexSet *visibleColIndices;
@property (nonatomic, strong) SCGenericReuseCache *reuseCache;
@property (nonatomic, strong) NSMutableDictionary *visibleCells;

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
        
        // Visible cells
        self.visibleCells = [NSMutableDictionary dictionary];
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
        self.visibleRowIndices = [self currentlyVisibleRows];
        self.visibleColIndices = [self currentlyVisibleCols];
        [self.visibleRowIndices enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [self addRowWithIndex:idx];
        }];
    }
}

#pragma mark - Reuse methods
- (void)addRowWithIndex:(NSUInteger)row
{
    [self.visibleColIndices enumerateIndexesUsingBlock:^(NSUInteger col, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row column:col];
        [self addCellAtIndexPath:indexPath];
    }];
}

- (void)removeRowWithIndex:(NSUInteger)row
{
    [self.visibleColIndices enumerateIndexesUsingBlock:^(NSUInteger col, BOOL *stop) {
        NSIndexPath *iPath = [NSIndexPath indexPathForRow:row column:col];
        [self removeCellAtIndexPath:iPath];
    }];
}

- (void)addColumnWithIndex:(NSUInteger)col
{
    [self.visibleRowIndices enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx column:col];
        [self addCellAtIndexPath:indexPath];
    }];
}

- (void)removeColumnWithIndex:(NSUInteger)col
{
    [self.visibleRowIndices enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx column:col];
        [self removeCellAtIndexPath:indexPath];
    }];
}

- (void)addCellAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect cellFrame = [self frameForCellWithRow:indexPath.row col:indexPath.column];
    NSString *content = [NSString stringWithFormat:@"(%d,%d) %@", indexPath.row, indexPath.column, self.data[indexPath.row][indexPath.column]];
    id cell = [self.reuseCache dequeueObject];
    [self addCell:cell withFrame:cellFrame content:content];
    [self.visibleCells setObject:cell forKey:indexPath];
}

- (void)removeCellAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = self.visibleCells[indexPath];
    if(cell) {
        [self removeCell:cell];
        [self.reuseCache returnToCache:cell];
        [self.visibleCells removeObjectForKey:indexPath];
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
    NSUInteger maxCell = MIN(ceil(CGRectGetMaxY(self.scrollView.bounds) / self.rowHeight), [self.data count]);
    NSUInteger noCells = maxCell - minCell;
    return [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(minCell, noCells)];
}

- (NSIndexSet *)currentlyVisibleCols
{
    NSUInteger minCell = MAX(floor(CGRectGetMinX(self.scrollView.bounds) / self.columnWidth), 0);
    NSUInteger maxCell = MIN(ceil(CGRectGetMaxX(self.scrollView.bounds) / self.columnWidth), [self.data[0] count]);
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
    // Get the new cells
    NSIndexSet *currentRows = [self currentlyVisibleRows];
    NSIndexSet *currentCols = [self currentlyVisibleCols];
    
    // Which are new?
    NSIndexSet *newRows = [currentRows complementSet:self.visibleRowIndices];
    NSIndexSet *newCols = [currentCols complementSet:self.visibleColIndices];
    // And which have disappeared?
    NSIndexSet *lostRows = [self.visibleRowIndices complementSet:currentRows];
    NSIndexSet *lostCols = [self.visibleColIndices complementSet:currentCols];
    
    if([lostRows count] > 0) {
        [lostRows enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [self removeRowWithIndex:idx];
        }];
    }
    if([lostCols count] > 0) {
        [lostCols enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [self removeColumnWithIndex:idx];
        }];
    }

    self.visibleColIndices = currentCols;
    self.visibleRowIndices = currentRows;
    
    if([newRows count] > 0) {
        [newRows enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [self addRowWithIndex:idx];
        }];
    }
    if([newCols count] > 0) {
        [newCols enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [self addColumnWithIndex:idx];
        }];
    }
}


@end
