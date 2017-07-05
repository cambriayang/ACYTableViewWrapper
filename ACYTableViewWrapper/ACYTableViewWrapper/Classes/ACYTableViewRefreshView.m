//
//  ACYTableViewRefreshView.m
//  webApp
//
//  Created by yeyang on 2017/5/22.
//  Copyright © 2017年 lufax. All rights reserved.
//

#import "ACYTableViewRefreshView.h"

@interface ACYTableViewRefreshView ()

@property (nonatomic, strong, readwrite) UIImageView *arrowView;
@property (nonatomic, strong, readwrite) UIImageView *titleView;
@property (nonatomic, strong, readwrite) UIActivityIndicatorView *activityView;

@end

@implementation ACYTableViewRefreshView : UIView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self layoutViews];
    }
    
    return self;
}

- (void)layoutViews {
    self.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_list_rf_title"]];
    
    [self addSubview:self.titleView];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self).offset(25/2.0);
        make.size.equalTo(CGSizeMake(140, 25));
    }];
    
    self.arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_list_rf_down"]];
    
    [self addSubview:self.arrowView];
    
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleView.mas_left);
        make.size.equalTo(CGSizeMake(25, 25));
        make.centerY.equalTo(self.titleView);
    }];
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [self.activityView setHidesWhenStopped:YES];
    
    [self addSubview:self.activityView];
    
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.arrowView);
        make.centerX.equalTo(self.arrowView);
    }];
    
    [self.activityView stopAnimating];
}

@end
