//
//  CAYTableView.h
//  ACYTableViewWrapper
//
//  Created by yeyang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACYTableViewRefreshView.h"

NS_ASSUME_NONNULL_BEGIN

//此处代码是为了偷个懒，常用的初始化方式，如果需要定制化，请在对应的VC处理（为了直接使用ACYTableView，而不用改变基类的继承关系）。
#define ConvenienceInitACYTableView(tableView) \
ACYConvenienceInitACYTableView(tableView, self.datasource)

#define ACYConvenienceInitACYTableView(tableView, datasource) \
{\
if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {\
self.edgesForExtendedLayout = UIRectEdgeNone;\
}\
\
CGRect rect = self.view.bounds;\
\
rect.size.height -= 64;\
\
tableView = [[ACYTableView alloc] initWithFrame:rect];\
\
[self.view addSubview:tableView];\
\
tableView.dataSource = datasource;\
tableView.delegate = (id <UITableViewDelegate, UIScrollViewDelegate>)self;\
\
tableView.backgroundColor = [UIColor clearColor];\
tableView.separatorStyle = UITableViewCellSeparatorStyleNone;\
tableView.separatorColor = [UIColor clearColor];\
}

@class ACYTableRow;
@class ACYTableView;
static const CGFloat RefreshViewHeight = 60.0;
static const CGFloat LoadMoreCellHeight = 60.0;
static const CGFloat TableFooterHeight = 30.0;

typedef void (^ACYTableViewLoadingMoreEvent) (ACYTableView *tableView, ACYTableRow *row);
typedef void (^ACYTableViewRefreshEvent) (ACYTableView *tableView);

typedef NS_ENUM(NSUInteger, ACYTableViewState) {
    //Refresh State
    ACYTableViewStateNormal,
    ACYTableViewStateRefreshPulling,
    ACYTableViewStateRefreshLoading,
    //Load More State
    ACYTableViewStateLoadMoreBegin,
    ACYTableViewStateLoadMoreFinish,
    ACYTableViewStateLoadMoreError
};

@interface ACYTableView : UITableView

@property (nonatomic, copy, readonly) ACYTableViewLoadingMoreEvent loadMore;
@property (nonatomic, copy, readonly) ACYTableViewRefreshEvent refresh;
@property (nonatomic, assign, readonly) ACYTableViewState state;
@property (nonatomic, strong,readonly) ACYTableViewRefreshView *refreshView;
- (void)setTableState:(ACYTableViewState)aStatus;

- (void)setEmptyView:(UIView *)emptyView;
- (void)showEmptyView;
- (void)hideEmptyView;

- (void)clearNoMoreDataFooterView;
//Use the default tips "" & default color 0xEDF2F6
- (void)setNoMoreDataFooterView;
//Default color is 0xEDF2F6
- (void)setNoMoreDataFooterView:(nullable NSString *)tips height:(CGFloat)height;
- (void)setNoMoreDataFooterView:(nullable NSString *)tips height:(CGFloat)height backGroudColor:(UIColor *)color;

- (void)setRefreshEvent:(nullable ACYTableViewRefreshEvent)refresh loadMoreEvent:(nullable ACYTableViewLoadingMoreEvent)loadMore;
//If you use load more function, Please remember update total count(may be change according to server)
- (void)setTotalCount:(NSUInteger)totalCount pageSize:(NSUInteger)pageSize currentPage:(NSUInteger)currentPage;

@end

NS_ASSUME_NONNULL_END
