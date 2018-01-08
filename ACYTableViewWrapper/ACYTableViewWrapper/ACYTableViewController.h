//
//  CAYTableViewController.h
//  ACYTableViewWrapper
//
//  Created by yeyang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ACYBaseViewController.h"
#import "ACYTableView.h"
#import "ACYTableViewDataSource.h"

@interface ACYTableViewController : ACYBaseViewController
@property (nonatomic, strong) ACYTableView *myTableView;
@property (nonatomic, strong) ACYTableViewDataSource *dataSource;
@end
