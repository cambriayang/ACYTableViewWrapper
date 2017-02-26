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

@property(nonatomic, strong) ACYTableViewDelegateProxy *delegateProxy;

@end

@implementation ACYTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.separatorColor = [UIColor lightGrayColor];
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, CGFLOAT_MIN)];
    
    self.tableFooterView = view;
}

@end
