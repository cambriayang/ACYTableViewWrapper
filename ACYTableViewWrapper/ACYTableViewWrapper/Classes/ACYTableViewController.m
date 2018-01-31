//
//  CAYTableViewController.m
//  ACYTableViewWrapper
//
//  Created by yeyang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import "ACYTableViewController.h"

@interface ACYTableViewController () <UITableViewDelegate, UIScrollViewDelegate>

@end

@implementation ACYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTableView = [ACYTableView new];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self.view addSubview:self.myTableView];
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectNav = self.navigationController.navigationBar.frame;

    self.myTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - (rectNav.size.height+rectStatus.size.height));
    
    self.dataSource = [ACYTableViewDataSource new];
    self.myTableView.dataSource = self.dataSource;
    self.myTableView.delegate = self;
    self.myTableView.separatorColor = [UIColor clearColor];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.myTableView.estimatedRowHeight = 0;
    self.myTableView.estimatedSectionFooterHeight = 0;
    self.myTableView.estimatedSectionHeaderHeight = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
