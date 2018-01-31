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

@property (nonatomic, strong, readonly) UILabel *titleView;
@property (nonatomic, strong, readonly) UIImageView *circleView;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
- (void)startAnimation;

@end

NS_ASSUME_NONNULL_END
