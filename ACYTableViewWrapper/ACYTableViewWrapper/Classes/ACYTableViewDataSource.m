//
//  ACYTableViewDataSource.m
//  ACYTableViewWrapper
//
//  Created by CambriaYang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import "ACYTableViewDataSource.h"

#import "ACYTableSection.h"
#import "ACYTableRow.h"

@interface ACYTableViewDataSource () {
    NSMutableDictionary *_classMap;
}

@end

@implementation ACYTableViewDataSource

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    if (_classMap == nil) {
        _classMap = [NSMutableDictionary dictionary];
    }
    
    if (cellClass == nil) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"==[%s, cellClass can not be nil!]==", __FUNCTION__] userInfo:nil];
    }
    
    [_classMap setObject:cellClass forKey:identifier];
}

- (nullable NSArray <__kindof ACYNode *> *)allSections {
    return [self children];
}

- (nullable NSArray <__kindof ACYNode *> *)sections {
    return [self children];
}

- (void)setSections:(nullable NSArray <__kindof ACYNode *> *)sections {
    [self setChildren:sections];
}

- (void)addSection:(__kindof ACYTableSection *)section {
    if (section == nil && ![section isKindOfClass:[ACYTableSection class]]) {
        [NSException raise:NSInvalidArgumentException format:@"==[The section MUST NOT be nil or empty.]=="];
    }
    
    [self addChild:section];
}

- (void)addSectionsFromArray:(NSArray <__kindof ACYTableSection *> *)array {
    [self addSectionsFromArray:array];
}

- (NSArray <ACYTableRow *> *)rowsInSection:(NSInteger)section {
    NSArray *rows = nil;
    
    do {
        rows = [[[self children] objectOrNilAtIndex:section] allRows];
        if (![rows isKindOfClass:[NSArray class]]) {
            rows = nil;
            break;
        }
    } while (0);
    
    return rows;
}

- (ACYTableRow *)rowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *rows = [self rowsInSection:indexPath.section];
    
    return [rows objectOrNilAtIndex:indexPath.row];
}

- (void)invalidAutoCalculatedCellHeight {
    NSArray *sections = [self allSections];
    
    for (ACYTableSection *section in sections) {
        for (ACYTableRow *row in section) {
            if ([row autoAdjustCellHeight]) {
                row.cellHeight = 0;
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self allSections].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self rowsInSection:section].count;
}

/**
 *  @see http://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights
 */
- (CGFloat)autoAdjustedCellHeightAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView {
    CGFloat height = 0.0;
    
    ACYTableRow *row = [self rowAtIndexPath:indexPath];
    
    if ([row cellHeight] > 0) {
        //If computed or overide 'cellHeight', just return
        height = [row cellHeight];
    } else {
        UIView *layoutView = [row autoLayoutView];
        
        if (!layoutView) {
            UITableViewCell *cell = [row cellForTableViewAutoAdjust];
            
            [row updateCell:cell indexPath:indexPath];
            
            layoutView = cell;
        }
        
        layoutView.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(layoutView.bounds));
        
        // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints. (Note that you must set the preferredMaxLayoutWidth on multi-line UILabels inside the -[layoutSubviews] method of the UITableViewCell subclass, or do it manually at this point before the below 3 lines!)
        
        [layoutView setNeedsLayout];
        [layoutView setNeedsDisplay];
        [layoutView setNeedsUpdateConstraints];
        
        // Get the actual height required for the cell's contentView
        if ([layoutView isKindOfClass:[UITableViewCell class]]) {
            height = [[(UITableViewCell *)layoutView contentView] systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        } else {
            height = [layoutView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        }
    }
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom of the cell's contentView and the bottom of the table view cell.
//    height += 1.0f;
    
    //store the height
    row.cellHeight = height;
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ACYTableSection *tableSection = [[self allSections] objectOrNilAtIndex:indexPath.section];
    
    ACYTableRow *tableRow = [[tableSection allRows] objectOrNilAtIndex:indexPath.row];
    
    UITableViewCell *tableCell = [tableRow cellForTableView:tableView indexPath:indexPath];
    
    [tableRow updateCell:tableCell indexPath:indexPath];
    
    return tableCell;
}

@end
