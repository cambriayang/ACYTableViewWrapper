//
//  ACYLoadingMoreRetryRow.m
//  webApp
//
//  Created by yeyang on 2017/5/19.
//  Copyright © 2017年 lufax. All rights reserved.
//

#import "ACYLoadingMoreRetryRow.h"
#import <Masonry.h>
#import "Utility.h"
#import "LuCommonConstants.h"

@interface ACYLoadingMoreRetryRow ()

@property (nonatomic, weak, readwrite) ACYLoadingMoreRetryCell *cell;

@end

@implementation ACYLoadingMoreRetryRow

- (UITableViewCell *)createCellForAutoAdjustedTableViewCell {
    ACYLoadingMoreRetryCell *cell = [[ACYLoadingMoreRetryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self reuseIdentifier]];
    
    self.cell = cell;
    
    cell.tipsLbl.hidden = NO;
    cell.activityView.hidden = YES;
    [cell.activityView stopAnimating];
    
    return cell;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    ACYLoadingMoreRetryCell *cell = [tableView dequeueReusableCellWithIdentifier:[self reuseIdentifier]];
    
    if (cell == nil) {
        cell = (ACYLoadingMoreRetryCell *)[self createCellForAutoAdjustedTableViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.tipsLbl.hidden = NO;
    cell.activityView.hidden = YES;
    [cell.activityView stopAnimating];
    
    self.cell = cell;
    
    return cell;
}

- (BOOL)autoAdjustCellHeight {
    return NO;
}

- (CGFloat)cellHeight {
    return 60;
}

- (void)updateCell:(ACYLoadingMoreRetryCell *)cell indexPath:(NSIndexPath *)indexPath {
}

- (void)setToLoadingState {
    self.cell.tipsLbl.hidden = YES;
    self.cell.activityView.hidden = NO;
    [self.cell.activityView startAnimating];
}

- (void)setToNormalState {
    self.cell.tipsLbl.hidden = NO;
    self.cell.activityView.hidden = YES;
    [self.cell.activityView stopAnimating];
}

@end

@interface ACYLoadingMoreRetryCell ()

@property (nonatomic, strong, readwrite) UILabel *tipsLbl;
@property (nonatomic, strong, readwrite) UIActivityIndicatorView *activityView;

@end

@implementation ACYLoadingMoreRetryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self layoutViews];
    }
    
    return self;
}

- (void)layoutViews {
    self.backgroundColor = [Utility colorWithHex:@"EDF2F6"];
    
    UILabel *lbl = [[UILabel alloc] init];
    
    lbl.text = @"数据异常，请点击重试";
    lbl.textColor = NORMAL_COLOR_1;
    lbl.font = [UIFont systemFontOfSize:15.0];
    
    [self.contentView addSubview:lbl];
    
    lbl.hidden = NO;
    
    self.tipsLbl = lbl;
    
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [activityView startAnimating];
    
    [self.contentView addSubview:activityView];
    
    [activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    
    activityView.hidden = YES;
    [activityView stopAnimating];
    
    self.activityView = activityView;
    
    [self.activityView setHidesWhenStopped:YES];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
}

@end
