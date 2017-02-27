//
//  ACYTableRow.h
//  ACYTableViewWrapper
//
//  Created by CambriaYang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import "ACYNode.h"

#import <UIKit/UIKit.h>

@class ACYTableSection;
@class ACYTableRow;

typedef NS_ENUM(NSUInteger, ACYTableRowState) {
    ACYTableRowStateDefault,
    ACYTableRowStateOpen
};

NS_ASSUME_NONNULL_BEGIN

/**
 The Click Event, you can also use didSelect method for process events intensively
 *
 * @param row
 * @param indexPath
 */
typedef void (^SelectRowEvent) (UITableView *tableview, ACYTableRow *row, UITableViewCell *cell, NSIndexPath *indexPath);

@interface ACYTableRow : ACYNode

@property (nonatomic, copy) SelectRowEvent selectRowEvent;
@property (nonatomic, assign, readwrite) CGFloat cellHeight;
@property (nonatomic, assign) ACYTableRowState state;
/**
 *  return 'YES' if you want autojust cell height, strongly recommended(with autolayout)
 *
 *  @return 
 */
- (BOOL)autoAdjustCellHeight;

- (__kindof UITableViewCell *)cellForTableViewAutoAdjust;

/**
 * @required
 */
- (NSString *)reuseIdentifier;

/**
 * @required
 */
- (__kindof UITableViewCell *)createCellForAutoAdjustedTableViewCell;

/**
 *  when computed constraints changed, call this.
 *  @waring already displayed cell won't auto height. need reload row
 *  @see autoAdjustCellHeight
 */
- (void)invalidateAutoCellHeight:(ACYTableRowState)state;


/**
 *  Creates a new cell that the table view row manages.
 *
 *  @return The newly created cell that the row manages.
 */
- (__kindof UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

/**
 Do the specific things for cell
 *
 * @param cell
 * @param indexPath
 */
- (void)updateCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

- (nullable NSIndexPath *)indexPath;

/**
 * If not autolayout for whole cell, return this view. Default is nil
 */
- (nullable UIView *)autoLayoutView;

/**
 * optional
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * optional
 */
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 * optional
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

- (CGFloat)estimatedHeight;

/**
 * Override point
 */
- (void)rowWillAddToSection:(ACYTableSection *)section;
- (void)rowDidAddToSection:(ACYTableSection *)section;

@end

NS_ASSUME_NONNULL_END
