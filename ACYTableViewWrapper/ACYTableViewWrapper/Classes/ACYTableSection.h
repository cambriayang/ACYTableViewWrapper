//
//  ACYTableSection.h
//  ACYTableViewWrapper
//
//  Created by CambriaYang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import "ACYNode.h"

#import <UIKit/UIKit.h>

@class ACYTableRow, ACYTableSection;

NS_ASSUME_NONNULL_BEGIN

typedef void (^SectionClickEvent) (ACYTableSection *section);

typedef NS_ENUM (NSUInteger, ACYTableSectionContentType) {
    ACYTableSectionContentTypeTitle,
    ACYTableSectionContentTypeImage,
    ACYTableSectionContentTypeCustomView
};

@interface ACYTableSection : ACYNode

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, copy, nullable) SectionClickEvent sectionClickEvent;

/**
 *  Initialier set
 *
 *  @return
 */
- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithImage:(UIImage *)image;
- (instancetype)initWithCustomView:(UIView *)customView;

/**
 *  Convinent Initializer
 *
 *
 *  @return
 */
+ (ACYTableSection *)sectionWithTitle:(NSString *)title;
+ (ACYTableSection *)sectionWithImage:(UIImage *)image;
+ (ACYTableSection *)sectionWithCustomView:(UIView *)view;

- (UITableViewHeaderFooterView *)viewForTableView:(UITableView *)tableView;
- (UITableViewHeaderFooterView *)viewForHeaderInTableView:(UITableView *)tableView section:(NSInteger)section;
- (UITableViewHeaderFooterView *)viewForFooterInTableView:(UITableView *)tableView section:(NSInteger)section;

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section;
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(nonnull UIView *)view forSection:(NSInteger)section;

- (CGFloat)heightForHeaderInTableView:(UITableView *)tableView inSection:(NSInteger)section;
- (CGFloat)heightForFooterInTableView:(UITableView *)tableView inSection:(NSInteger)section;

- (nullable NSArray *)allRows;


/**
 All rows will be reset, including exist ones
 *
 * @param rows
 */
- (void)setAllRows:(nullable NSArray <__kindof ACYNode *> *)rows;

- (nullable ACYTableRow *)rowAtIndex:(NSUInteger)index;


/**
 * Add row into exist ones
 *
 * @param row
 */
- (void)addRow:(nullable ACYTableRow *)row;

/**
 * Add rows into exist ones
 *
 * @param array
 */
- (void)addRowsFromArray:(nullable NSArray <__kindof ACYNode *> *)array;

- (NSUInteger)section;

@end

NS_ASSUME_NONNULL_END
