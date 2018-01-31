//
//  TestViewController.m
//  ACYTableViewWrapper
//
//  Created by yeyang on 2017/2/17.
//  Copyright © 2017年 yeio. All rights reserved.
//

#import "DemoViewController.h"

#import "ACYTableViewWrapper.h"
#import "DemoTableSection.h"

@interface DemoViewController () <UITableViewDelegate>

@property (nonatomic, strong) ACYTableView *myTableView;
@property (nonatomic, strong) ACYTableViewDataSource *ds;
@property (nonatomic, strong) DemoTableSection *s1;

@end

@implementation DemoViewController

- (void)dealloc {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    CGRect rect = self.view.bounds;
    
    rect.size.height -= 60;
    
    _myTableView = [[ACYTableView alloc] initWithFrame:rect];
    
    [self.view addSubview:_myTableView];
    
    _ds = [[ACYTableViewDataSource alloc] init];
    
    _s1 = [[DemoTableSection alloc] init];
    
    [_ds addSection:_s1];
    
    self.myTableView.dataSource = _ds;
    self.myTableView.delegate = self;    
}

@end
