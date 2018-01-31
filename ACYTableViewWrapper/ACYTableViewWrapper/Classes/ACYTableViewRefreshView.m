//
//  ACYTableViewRefreshView.m
//  webApp
//
//  Created by yeyang on 2017/5/22.
//  Copyright © 2017年 lufax. All rights reserved.
//

#import "ACYTableViewRefreshView.h"
//#import "CircleProgressBar.h"

@interface ACYTableViewRefreshView ()

@property (nonatomic, strong, readwrite) UILabel *titleView;
//@property (nonatomic, strong, readwrite) CircleProgressBar *dragingLoadingView;
@property (nonatomic, strong, readwrite) UIImageView *circleView;
@property (nonatomic, strong, readwrite) UIImageView *placeView;

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
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    UIView *maskView = [UIView new];
    
    [self addSubview:maskView];
    self.clipsToBounds = NO;
    
    maskView.backgroundColor = [UIColor clearColor];
    
    maskView.frame = CGRectMake(0, -1000, self.frame.size.width, 1000);
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleView = [[UILabel alloc] initWithFrame:CGRectMake((width - 200)/2.0 + 40, (height - 20)/2.0, 200, 20)];
    
    [self addSubview:self.titleView];
    
    self.titleView.text = @"值得信赖的投资理财平台";
    self.titleView.textColor = [UIColor whiteColor];
    self.titleView.font = [UIFont systemFontOfSize:13.0];
    
    [self.titleView sizeToFit];
    
    self.placeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_loading_place"]];
    
    [self addSubview:self.placeView];
    
    self.placeView.frame = CGRectMake(CGRectGetMinX(self.titleView.frame) - 5 - 15, (height - 10)/2.0 - 2, 10, 10);
    
    self.circleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_loading_circle"]];
    
    [self addSubview:self.circleView];
    
    self.circleView.frame = CGRectMake(CGRectGetMinX(self.titleView.frame) - 5 - 20, (height - 20)/2.0 - 2, 20, 20);
    
    self.circleView.hidden = YES;
    
    [self startAnimation];

//    //Progress
//    self.dragingLoadingView = [[CircleProgressBar alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleView.frame) - 5 - 20, (height - 20)/2.0 - 2, 20, 20)];
//
//    [self addSubview:self.dragingLoadingView];
//
//    // Progress Bar Customization
//    [self.dragingLoadingView setProgressBarWidth:(1.0)];
//    [self.dragingLoadingView setStartAngle:-90];
//    [self.dragingLoadingView setProgressBarProgressColor:[Utility colorWithHex:@"7391FA"]];
//    [self.dragingLoadingView setProgressBarTrackColor:[UIColor clearColor]];
//    [self.dragingLoadingView setProgress:0 animated:YES];
//    [self.dragingLoadingView setBackgroundColor:[UIColor clearColor]];
}

- (void)startAnimation {
    [self.circleView.layer removeAllAnimations];
    
    //旋转动画
    CABasicAnimation *rotationAnimation;
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    rotationAnimation.duration = 1;
    
    rotationAnimation.repeatCount = INTMAX_MAX;
    
    rotationAnimation.cumulative = NO;
    
    rotationAnimation.removedOnCompletion = NO;
    
    rotationAnimation.fillMode = kCAFillModeForwards;
    
    [self.circleView.layer addAnimation:rotationAnimation forKey:@"Rotation"];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
//    [self.dragingLoadingView setProgress:progress animated:animated];
}

@end
