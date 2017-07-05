//
//  ACYLoadingMoreRetryRow.h
//  webApp
//
//  Created by yeyang on 2017/5/19.
//  Copyright © 2017年 lufax. All rights reserved.
//

#import "ACYTableRow.h"

@class ACYLoadingMoreRetryCell;

NS_ASSUME_NONNULL_BEGIN

@interface ACYLoadingMoreRetryRow : ACYTableRow

@property (nonatomic, weak, readonly) ACYLoadingMoreRetryCell *cell;

- (void)setToLoadingState;
- (void)setToNormalState;

@end

@interface ACYLoadingMoreRetryCell : UITableViewCell

@property (nonatomic, strong, readonly) UILabel *tipsLbl;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityView;

@end

NS_ASSUME_NONNULL_END
