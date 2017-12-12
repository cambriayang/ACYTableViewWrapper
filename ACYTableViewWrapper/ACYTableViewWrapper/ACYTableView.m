//
//  CAYTableView.m
//  ACYTableViewWrapper
//
//  Created by yeyang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import "ACYTableView.h"

#import "ACYTableViewDelegateProxy.h"
#import "ACYTableViewDataSource.h"
#import "ACYLoadingMoreRow.h"
#import "ACYTableSection.h"
#import "ACYLoadingMoreRetryRow.h"
#import "ACYTableViewRefreshView.h"
#import "Utility.h"
#import <Masonry.h>

static const NSInteger RefreshViewTag = 0x88768f;
static NSString * const DefaultTips = @"";

@interface ACYTableView ()

@property (nonatomic, strong) ACYTableViewDelegateProxy *delegateProxy;
@property (nonatomic, strong) UIView *emptyView;

@property (nonatomic, assign, readwrite) BOOL acyPagingEnable;
@property (nonatomic, assign, readwrite) ACYTableViewState state;
@property (nonatomic, assign, readwrite) NSUInteger totalPage;
@property (nonatomic, assign, readwrite) NSUInteger pageSize;
@property (nonatomic, assign, readwrite) NSUInteger totalCount;
@property (nonatomic, assign, readwrite) NSUInteger currentPage;
@property (nonatomic, copy, nonnull, readwrite) ACYTableViewLoadingMoreEvent loadMore;
@property (nonatomic, copy, nonnull, readwrite) ACYTableViewRefreshEvent refresh;
@property (nonatomic, assign) CGFloat contentOffsetY;
@property (nonatomic, copy) NSString *bottomTips;
@property (nonatomic, assign) CGFloat bottomViewHeight;
@property (nonatomic, strong)UIColor *moreViewBgColor;
@property (nonatomic, strong,readwrite) ACYTableViewRefreshView *refreshView;

@end

@implementation ACYTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.separatorColor = [UIColor lightGrayColor];
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        [self addSubview:_emptyView];
    
        _emptyView.backgroundColor = [UIColor clearColor];
        _emptyView.hidden = YES;
        self.acyPagingEnable = NO;
        self.currentPage = 1;
        self.refreshView = nil;
        self.contentOffsetY = 0.0;
        self.state = ACYTableViewStateNormal;
        self.bottomTips = DefaultTips;
        self.bottomViewHeight = TableFooterHeight;
        self.moreViewBgColor = [Utility colorWithHex:@"EDF2F6"];
    }
    
    return self;
}

- (void)setTableState:(ACYTableViewState)aStatus {
    _state = aStatus;
    
    switch (aStatus) {
        case ACYTableViewStateRefreshLoading:
        {
            self.refreshView.circleView.hidden = NO;
            [self.refreshView setProgress:0 animated:YES];
        }
            break;
        case ACYTableViewStateNormal:
        case ACYTableViewStateLoadMoreFinish:
        case ACYTableViewStateLoadMoreBegin:
        {
            self.refreshView.circleView.hidden = YES;
            self.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        }
            break;
        case ACYTableViewStateRefreshPulling:
        {
            self.refreshView.circleView.hidden = YES;
        }
            break;
        case ACYTableViewStateLoadMoreError: {
            ACYTableViewDataSource *ds = (ACYTableViewDataSource *)self.dataSource;
            
            ACYTableRow *row = (ACYTableRow *)ds.lastChild.lastChild;
            
            if ([row isKindOfClass:[ACYLoadingMoreRow class]]) {
                [ds removeChild:row];
            }
            
            ACYLoadingMoreRetryRow *retry = [[ACYLoadingMoreRetryRow alloc] init];
            
            retry.selectRowEvent = ^(UITableView *tableView, ACYTableRow *row, UITableViewCell *cell, NSIndexPath *indexPath) {
                ACYLoadingMoreRetryRow *retry = (ACYLoadingMoreRetryRow *)row;
                
                [retry setToLoadingState];
                
                ACYTableView *table = (ACYTableView *)tableView;
                
                ACYTableViewDataSource *ds = (ACYTableViewDataSource *)table.dataSource;
                
                [ds removeChild:row];
                
                if (self.loadMore && (table.state != ACYTableViewStateLoadMoreBegin && table.state != ACYTableViewStateRefreshPulling && table.state != ACYTableViewStateRefreshLoading)) {
                    [self setTableState:ACYTableViewStateLoadMoreBegin];
                    
                    self.loadMore(table, row);
                }
            };
            
            [ds.lastChild addChild:retry];
            
            [self reloadData];
        }
        default:
            break;
    }
}

- (void)setTotalCount:(NSUInteger)totalCount pageSize:(NSUInteger)pageSize currentPage:(NSUInteger)currentPage {
    if (totalCount <= 0 || pageSize <= 0) {
        self.pageSize = -1;
        self.totalCount = -1;
        self.currentPage = -1;
        self.totalPage = -1;
        
        NSLog(@"=[如果你需要LoadMore功能，请确保Total count和page size]=");
        
        return;
    }
    
    self.pageSize = pageSize;
    self.totalCount = totalCount;
    self.currentPage = currentPage;
    
    NSUInteger result = totalCount / pageSize;
    
    NSUInteger page = totalCount % pageSize;
    
    if (page > 0) {
        result++;
    }
    
    self.totalPage = result;
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
}

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
    if (self.state == ACYTableViewStateRefreshLoading) {
        [self.refreshView setProgress:0 animated:YES];
    } else if (self.state == ACYTableViewStateRefreshPulling || self.state == ACYTableViewStateNormal) {
        CGFloat offset = (-self.contentOffset.y/60.0) >= 1.0 ? 1.0: (-self.contentOffset.y/60.0);
        [self.refreshView setProgress:offset animated:YES];
    }
}

- (void)setDelegate:(id<UITableViewDelegate, UIScrollViewDelegate>)delegate {
    if (delegate == nil) {
        [super setDelegate:nil];
        self.delegateProxy = nil;
        return;
    }
    
    if (self.delegateProxy == nil) {
        self.delegateProxy = [ACYTableViewDelegateProxy alloc];
    }
    
    self.delegateProxy.target = delegate;
    
    [super setDelegate:(id <UITableViewDelegate, UIScrollViewDelegate>)self.delegateProxy];
}

- (void)setNoMoreDataFooterView:(nullable NSString *)tips height:(CGFloat)height backGroudColor:(UIColor *)color {
    self.moreViewBgColor = color;
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = self.moreViewBgColor;
    
    UILabel *lbl = [[UILabel alloc] init];
    
    [view addSubview:lbl];
    
    if (self.bottomTips.length > 0 && ([tips isEqualToString:DefaultTips])) {
        lbl.text = self.bottomTips;
    } else {
        lbl.text = tips;
    }
    
    if (self.bottomViewHeight > 0 && (self.bottomViewHeight != TableFooterHeight)) {
        view.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.bottomViewHeight);
    } else {
        view.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), TableFooterHeight);
    }
    
    self.bottomTips = tips;
    self.bottomViewHeight = height;
    
    lbl.font = [UIFont systemFontOfSize:13.0];
    lbl.textColor = [Utility colorWithHex:@"acb4b9"];
    
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.centerX.equalTo(view.mas_centerX);
    }];
    
    self.tableFooterView = view;
}

- (void)setNoMoreDataFooterView:(NSString *)tips height:(CGFloat)height {
    [self setNoMoreDataFooterView:tips height:height backGroudColor:self.moreViewBgColor];
}

- (void)clearNoMoreDataFooterView {
    self.tableFooterView = nil;
}

- (void)setNoMoreDataFooterView {
    [self setNoMoreDataFooterView:DefaultTips height:self.bottomViewHeight];
}

- (void)setEmptyView:(UIView *)emptyView {
    CGRect rect = self.frame;
    
    //Delete the old one
    if (_emptyView) {
        [_emptyView removeFromSuperview];
        _emptyView = nil;;
    }
    
    _emptyView = emptyView;
    
    rect.origin.x = 0;
    rect.origin.y = 0;
    
    emptyView.frame = rect;
    
    [self addSubview:_emptyView];
    
    _emptyView.hidden = YES;
}

- (void)showEmptyView {
    if (_emptyView && _emptyView.hidden) {
        _emptyView.hidden = NO;
        
        ACYTableViewDataSource *ds = (ACYTableViewDataSource *)self.dataSource;
        
        for (ACYTableSection *section in ds.allSections) {
            [section removeAllChild];
        }
        
        [self bringSubviewToFront:_emptyView];
    }
}

- (void)hideEmptyView {
    if (_emptyView && !_emptyView.hidden) {
        _emptyView.hidden = YES;
    }
}

- (void)setRefreshEvent:(ACYTableViewRefreshEvent)refresh loadMoreEvent:(ACYTableViewLoadingMoreEvent)loadMore {
    if (refresh == nil) {
        [self.refreshView removeFromSuperview];
        
        self.refreshView = nil;
    }
    
    self.refresh = refresh;
    
    self.currentPage = 1;
    
    ACYTableViewRefreshView *view = [self viewWithTag:RefreshViewTag];
    
    if (view == nil) {
        self.refreshView = [[ACYTableViewRefreshView alloc] initWithFrame:CGRectMake(0, -RefreshViewHeight, [UIScreen mainScreen].bounds.size.width, RefreshViewHeight)];
        
        self.refreshView.tag = RefreshViewTag;
        
        [self addSubview:self.refreshView];
    }
    
    if (loadMore == nil) {
        self.acyPagingEnable = NO;
    } else {
        self.acyPagingEnable = YES;
        
        self.loadMore = loadMore;
    }
}

- (void)reloadData {
    ACYTableViewDataSource *ds = nil;
    
    if ([self.dataSource isKindOfClass:[ACYTableViewDataSource class]]) {
        ds = (ACYTableViewDataSource *)self.dataSource;
    }
    
    ACYTableSection *lastSection = nil;
    
    if (self.acyPagingEnable) {
        lastSection  = (ACYTableSection *)[[ds allSections] lastObject];
        
        if (lastSection) {
            if (self.currentPage < self.totalPage) {
                //Has more data
                if ([[lastSection children] count] >= self.pageSize && ![lastSection.lastChild isKindOfClass:[ACYLoadingMoreRetryRow class]]) {
                    ACYLoadingMoreRow *row = [[ACYLoadingMoreRow alloc] init];
                    
                    if (![[[lastSection children] lastObject] isKindOfClass:[ACYLoadingMoreRow class]]) {
                        [lastSection addRow:row];
                        
                        self.currentPage++;
                    }
                }
    
                [self clearNoMoreDataFooterView];
            } else {
                //Has no more
                if ([[[lastSection children] lastObject] isKindOfClass:[ACYLoadingMoreRow class]] || [[[lastSection children] lastObject] isKindOfClass:[ACYLoadingMoreRetryRow class]]) {
                    [lastSection removeChild:[[lastSection children] lastObject]];
                }
                
                //Add nomore data footer
                if (lastSection.children.count > 0) {
                    [self setNoMoreDataFooterView];
                }
            }
        }
    }
    
    [super reloadData];
}

@end
