//
//  ACYTableRow.m
//  ACYTableViewWrapper
//
//  Created by CambriaYang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import "ACYTableRow.h"

@implementation ACYTableRow

- (UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    [NSException raise:NSObjectInaccessibleException format:@"==[The %s MUST be implemented by subclass]==", __FUNCTION__];
    
    return Nil;
}

- (UITableViewCell *)cellForTableViewAutoAdjust
{
    static NSDictionary *templateCellDict = nil;
    
    if (!templateCellDict) {
        templateCellDict = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    
    NSString *identifier = [self reuseIdentifier];
    
    NSString *key = [NSString stringWithFormat:@"%@_%lu", identifier, (unsigned long)self.state];
    
    UITableViewCell *cell = [templateCellDict objectForKey:key];
    
    if (!cell) {
        cell = [self createCellForAutoAdjustedTableViewCell];
        [templateCellDict setValue:cell forKey:key];
    }
    
    return cell;
}

- (NSString *)reuseIdentifier {
   [NSException raise:NSObjectInaccessibleException format:@"==[The %s MUST be implemented by subclass]==", __FUNCTION__];
    return nil;
}

- (UITableViewCell *)createCellForAutoAdjustedTableViewCell {
    [NSException raise:NSObjectInaccessibleException format:@"==[The %s MUST be implemented by subclass]==", __FUNCTION__];
    return nil;
}

- (CGFloat)cellHeight {
    return _cellHeight;
}

- (void)updateCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    [NSException raise:NSObjectInaccessibleException format:@"==[The %s MUST be implemented by subclass]==", __FUNCTION__];
}

- (BOOL)autoAdjustCellHeight {
    return NO;
}

- (void)invalidateAutoCellHeight:(ACYTableRowState)state {
    self.cellHeight = 0;
    self.state = state;
}

- (NSIndexPath *)indexPath {
    NSUInteger section = [self.parent nodeIndex];
    
    NSUInteger row = [self nodeIndex];
    
    if (section != NSNotFound && row != NSNotFound) {
        return [NSIndexPath indexPathForRow:row inSection:section];
    } else {
        return nil;
    }
}

- (UIView *)autoLayoutView {
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.selectRowEvent) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        self.selectRowEvent(self, cell, indexPath);
    }
}

- (void)rowDidAddToSection:(ACYTableSection *)section {
    
}

- (void)rowWillAddToSection:(ACYTableSection *)section {
    
}

- (CGFloat)estimatedHeight {
    return 60.0;
}

@end
