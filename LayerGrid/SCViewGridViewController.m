//
//  SCFirstViewController.m
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCViewGridViewController.h"
#import "SCViewGrid.h"
#import "SCDataFactory.h"

@interface SCViewGridViewController ()

@property (nonatomic, strong) SCViewGrid *grid;

@end

@implementation SCViewGridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.grid = [[SCViewGrid alloc] initWithFrame:self.view.bounds];
    self.grid.data = [SCDataFactory generateDataWithColumns:20 rows:100];
    [self.view addSubview:self.grid];
}


@end
