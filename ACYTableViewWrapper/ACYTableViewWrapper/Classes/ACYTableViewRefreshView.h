//
//  ACYTableViewRefreshView.h
//  webApp
//
//  Created by yeyang on 2017/5/22.
//  Copyright © 2017年 lufax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACYTableViewRefreshView : UIView

@property (nonatomic, strong, readonly) UIImageView *arrowView;
@property (nonatomic, strong, readonly) UIImageView *titleView;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityView;

@end

NS_ASSUME_NONNULL_END
