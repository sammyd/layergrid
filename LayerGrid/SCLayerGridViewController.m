//
//  SCSecondViewController.m
//  LayerGrid
//
//  Created by Sam Davies on 30/03/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

#import "SCLayerGridViewController.h"
#import "SCLayerGrid.h"
#import "SCDataFactory.h"

@interface SCLayerGridViewController ()

@property (nonatomic, strong) SCLayerGrid *grid;

@end

@implementation SCLayerGridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.grid = [[SCLayerGrid alloc] initWithFrame:self.view.bounds];
    self.grid.data = [SCDataFactory generateDataWithColumns:200 rows:1000];
    [self.view addSubview:self.grid];
}

@end
