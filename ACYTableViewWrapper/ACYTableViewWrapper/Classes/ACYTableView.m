//
//  CAYTableView.m
//  ACYTableViewWrapper
//
//  Created by yeyang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import "ACYTableView.h"

#import "ACYTableViewDelegateProxy.h"

@interface ACYTableView ()

@property (nonatomic, strong) ACYTableViewDelegateProxy *delegateProxy;
@property (nonatomic, strong) UIView *emptyView;

@end

@implementation ACYTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.separatorColor = [UIColor lightGrayColor];
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        [self addSubview:_emptyView];
        
        _emptyView.backgroundColor = [UIColor blueColor];
        _emptyView.hidden = YES;
    }
    return self;
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
}

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    if (delegate == nil) {
        [super setDelegate:nil];
        self.delegateProxy = nil;
        return;
    }
    
    if (self.delegateProxy == nil) {
        self.delegateProxy = [ACYTableViewDelegateProxy alloc];
    }
    
    self.delegateProxy.target = delegate;
    
    [super setDelegate:(id <UITableViewDelegate>)self.delegateProxy];
}

- (void)addEmptyTableViewFooterView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGFLOAT_MIN)];
    
    self.tableFooterView = view;
}

- (void)setEmptyView:(UIView *)emptyView {
    _emptyView = emptyView;
    
    [self addSubview:_emptyView];
}

- (void)showEmptyView {
    if (_emptyView && _emptyView.hidden) {
        _emptyView.hidden = NO;
    }
}

- (void)hideEmptyView {
    if (_emptyView && !_emptyView.hidden) {
        _emptyView.hidden = YES;
    }
}

@end
