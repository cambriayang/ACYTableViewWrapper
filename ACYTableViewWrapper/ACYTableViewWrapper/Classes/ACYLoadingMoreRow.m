//
//  ACYLoadingMoreRow.m
//  webApp
//
//  Created by yeyang on 2017/4/25.
//  Copyright © 2017年 lufax. All rights reserved.
//

#import "ACYLoadingMoreRow.h"
#import <Masonry/Masonry.h>

@interface ACYLoadingMoreRow ()

@property (nonatomic, weak, readwrite) ACYLoadingMoreCell *cell;

@end

@implementation ACYLoadingMoreRow

- (UITableViewCell *)createCellForAutoAdjustedTableViewCell {
    ACYLoadingMoreCell *cell = [[ACYLoadingMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self reuseIdentifier]];
    
    self.cell = cell;
    
    return cell;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    ACYLoadingMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:[self reuseIdentifier]];
    
    if (cell == nil) {
        cell = (ACYLoadingMoreCell *)[self createCellForAutoAdjustedTableViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    self.cell = cell;
    
    return cell;
}

- (BOOL)autoAdjustCellHeight {
    return NO;
}

- (CGFloat)cellHeight {
    return 60;
}

- (void)updateCell:(ACYLoadingMoreCell *)cell indexPath:(NSIndexPath *)indexPath {
}

@end

@interface ACYLoadingMoreCell ()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *loadingView;
@property (strong,nonatomic) CABasicAnimation *ani;

@end

@implementation ACYLoadingMoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self layoutViews];
    }
    
    return self;
}

- (void)layoutViews {
    UILabel *tipsLabel = [UILabel new];
    
    [self.contentView addSubview:tipsLabel];
    
    tipsLabel.text = @"正在努力加载";
    tipsLabel.font = [UIFont boldSystemFontOfSize:12];
    tipsLabel.textColor = [UIColor colorWithRed:(90)/255.0 green:(90)/255.0 blue:(90)/255.0 alpha:1.0];
    tipsLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    tipsLabel.textAlignment = NSTextAlignmentCenter;

    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    tipsLabel.backgroundColor = [UIColor clearColor];
    
    self.backgroundColor = [UIColor clearColor];
    
    if (_loadingView == nil) {
        UIImage *image = [UIImage imageNamed:@"lsu_feed_refresh_loading"];
        UIImageView *loadingView = [[UIImageView alloc] initWithImage:image];
        [self.contentView addSubview:_loadingView = loadingView];
    }
    
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(tipsLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [self.loadingView.layer addAnimation:self.ani forKey:nil];
}

- (CABasicAnimation *)ani{
    if (!_ani) {
        CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animate.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
        animate.duration = 1.0f;
        animate.repeatCount = 3000;
        animate.removedOnCompletion = NO;
        _ani = animate;
    }
    return _ani;
}

- (void)prepareForReuse {
    [super prepareForReuse];    
}


@end
