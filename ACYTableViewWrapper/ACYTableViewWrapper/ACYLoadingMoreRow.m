//
//  ACYLoadingMoreRow.m
//  webApp
//
//  Created by yeyang on 2017/4/25.
//  Copyright © 2017年 lufax. All rights reserved.
//

#import "ACYLoadingMoreRow.h"
#import <Masonry.h>

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
    self.backgroundColor = [UIColor clearColor];
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [activityView startAnimating];

    [self.contentView addSubview:activityView];
    
    [activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    self.activityView = activityView;
    
    [self.activityView setHidesWhenStopped:YES];
    
    self.activityView.hidden = NO;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
}

@end
