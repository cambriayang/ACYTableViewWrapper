//
//  TestViewController.m
//  ACYTableViewWrapper
//
//  Created by yeyang on 2017/2/17.
//  Copyright © 2017年 yeio. All rights reserved.
//

#import "DemoViewController.h"

#import "ACYTableViewWrapper.h"
#import "DemoTableRow.h"
#import "AnotherDemoTableRow.h"

@interface DemoViewController () <UITableViewDelegate>

@property (nonatomic, strong) ACYTableView *myTableView;
@property (nonatomic, strong) ACYTableViewDataSource *ds;
@property (nonatomic, strong) ACYTableSection *s1;
@property (nonatomic, strong) ACYTableSection *s2;

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
    
    self.myTableView.dataSource = self.ds;
    self.myTableView.delegate = self;
    
    NSMutableArray *rows = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        DemoTableRow *row = [[DemoTableRow alloc] init];
        
        [rows addObject:row];
        
        row.selectRowEvent = ^(ACYTableRow *row, UITableViewCell *cell, NSIndexPath *index) {
            NSLog(@"=[demoRow-%@-%@]=", row, index);
        } ;

        AnotherDemoTableRow *row2 = [[AnotherDemoTableRow alloc] init];
        
        row2.selectRowEvent = ^(ACYTableRow *row, UITableViewCell *cell, NSIndexPath *index) {
            NSLog(@"=[anotherDemoRow-%@-%@]=", row, index);
            AnotherDemoTableRow *tmpRow = (AnotherDemoTableRow *)row;
            
            if (tmpRow.state == ACYTableRowStateDefault) {
                [tmpRow invalidateAutoCellHeight:ACYTableRowStateOpen];
            } else {
                [tmpRow invalidateAutoCellHeight:ACYTableRowStateDefault];
            }
                        
            [self.myTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
        } ;
        
        [rows addObject:row2];
    }
    
    [self.s1 setAllRows:rows];
    
    [rows removeAllObjects];
    
//    for (int i = 0; i < 5; i++) {
//        AnotherDemoTableRow *row2 = [[AnotherDemoTableRow alloc] init];
//        
//        row2.selectRowEvent = ^(ACYTableRow *row, UITableViewCell *cell, NSIndexPath *index) {
//            NSLog(@"=[anotherDemoRow-%@-%@]=", row, index);
//            AnotherDemoTableRow *tmpRow = (AnotherDemoTableRow *)row;
//            
//            if (tmpRow.state == ACYTableRowStateDefault) {
//                [tmpRow invalidateAutoCellHeight:ACYTableRowStateOpen];
//            } else {
//                [tmpRow invalidateAutoCellHeight:ACYTableRowStateDefault];
//            }
//            
//            [self.myTableView reloadData];
//        } ;
//        
//        [rows addObject:row2];
//    }
//    
//    [self.s2 setAllRows:rows];
}


- (ACYTableSection *)s1 {
    if (!_s1) {
        _s1 = [[ACYTableSection alloc] init];
    }
    
    return _s1;
}

- (ACYTableSection *)s2 {
    if (!_s2) {
        _s2 = [[ACYTableSection alloc] init];
    }
    
    return _s2;
}

- (ACYTableViewDataSource *)ds {
    if (!_ds) {
        _ds = [[ACYTableViewDataSource alloc] init];
        
        [_ds addSection:self.s1];
        [_ds addSection:self.s2];
    }
    
    return _ds;
}

@end
