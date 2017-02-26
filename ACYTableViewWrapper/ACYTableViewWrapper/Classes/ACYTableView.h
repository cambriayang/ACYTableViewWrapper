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

/**
 *  Add an empty table view footer view so that no more seperator line after the content is over
 */
- (void)addEmptyTableViewFooterView;

@end

NS_ASSUME_NONNULL_END
