//
//  DemoTableSection.m
//  ACYTableViewWrapper
//
//  Created by yeyang on 2017/2/27.
//  Copyright © 2017年 CambriaYang. All rights reserved.
//

#import "DemoTableSection.h"

#import "DemoTableRow.h"
#import "AnotherDemoTableRow.h"

@implementation DemoTableSection

- (instancetype)initWithTitle:(NSString *)title {
    self = [super initWithTitle:title];
    
    if (self) {
        [self loadDataIfNeeded];
    }
    
    return  self;
}

- (void)loadDataIfNeeded {
    NSMutableArray *rows = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        DemoTableRow *row = [[DemoTableRow alloc] init];
        
        [rows addObject:row];
        
        row.selectRowEvent = ^(UITableView *tableView, ACYTableRow *row, UITableViewCell *cell, NSIndexPath *index) {
            NSLog(@"=[demoRow-%@-%@]=", row, index);
        } ;
        
        AnotherDemoTableRow *row2 = [[AnotherDemoTableRow alloc] init];
        
        row2.selectRowEvent = ^(UITableView *tableView, ACYTableRow *row, UITableViewCell *cell, NSIndexPath *index) {
            NSLog(@"=[anotherDemoRow-%@-%@]=", row, index);
            AnotherDemoTableRow *tmpRow = (AnotherDemoTableRow *)row;
            
            if (tmpRow.state == ACYTableRowStateDefault) {
                [tmpRow invalidateAutoCellHeight:ACYTableRowStateOpen];
            } else {
                [tmpRow invalidateAutoCellHeight:ACYTableRowStateDefault];
            }
            
            [tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
        } ;
        
        [rows addObject:row2];
    }
    
    [self setAllRows:rows];
}

@end
