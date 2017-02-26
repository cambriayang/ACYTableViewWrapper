//
//  CAYTableView.h
//  ACYTableViewWrapper
//
//  Created by yeyang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACYTableView : UITableView

- (void)setEmptyView:(UIView *)emptyView;
- (void)showEmptyView;
- (void)hideEmptyView;

@end

NS_ASSUME_NONNULL_END
