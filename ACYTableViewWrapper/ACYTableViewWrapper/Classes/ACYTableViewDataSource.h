//
//  ACYTableViewDataSource.h
//  ACYTableViewWrapper
//
//  Created by CambriaYang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import "ACYNode.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ACYTableSection;
@class ACYTableRow;

NS_ASSUME_NONNULL_BEGIN

@protocol ACYTableViewDataSource <NSObject>

/**
 * A convenient utility method for retrieving the row at specified index path.
 *
 * @param indexPath An index path locating a row in data source.
 * @return The row at specified index path.
 */
- (__kindof ACYTableRow *)rowAtIndexPath:(NSIndexPath *)indexPath;

- (nullable NSArray <__kindof ACYNode *> *)allSections;



/**
 According the constraints set to the views, calculating the height for a cell

 @param indexPath
 @param tableView
 @return 
 */
- (CGFloat)autoAdjustedCellHeightAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView;

@end

@interface ACYTableViewDataSource : ACYNode <UITableViewDataSource, ACYTableViewDataSource>

/**
 * Inserts a given section at the end of the section array.
 *
 * @param section The section object to add to the end of section array. This value MUST NOT be nil.
 */
- (void)addSection:(__kindof ACYTableSection *)section;
- (void)addSectionsFromArray:(NSArray <__kindof ACYTableSection *> *)array;
- (void)registerClass:(nonnull Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
- (void)invalidAutoCalculatedCellHeight;

@end

NS_ASSUME_NONNULL_END
