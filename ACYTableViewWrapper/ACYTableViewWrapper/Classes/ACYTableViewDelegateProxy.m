//
//  ACYTableViewDelegateProxy.m
//  ACYTableViewWrapper
//
//  Created by CambriaYang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import "ACYTableViewDelegateProxy.h"

#import "ACYTableViewDataSource.h"
#import "ACYTableRow.h"
#import "ACYTableSection.h"

@interface ACYTableViewDelegateProxy ()

@end

@implementation ACYTableViewDelegateProxy

- (void)setTarget:(id)target {
    _target = target;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if (self.target) {
        [invocation invokeWithTarget:self.target];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSMethodSignature *ms = nil;
    if (self.target) {
        ms = [self.target methodSignatureForSelector:sel];
    }
   
    return ms;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL retVal = NO;
    
    SEL selectors[] = {
        @selector(tableView:heightForRowAtIndexPath:),
        @selector(tableView:didSelectRowAtIndexPath:),
        @selector(tableView:viewForHeaderInSection:),
        @selector(tableView:viewForFooterInSection:),
        @selector(tableView:willDisplayHeaderView:forSection:),
        @selector(tableView:willDisplayFooterView:forSection:),
        @selector(tableView:heightForHeaderInSection:),
        @selector(tableView:heightForFooterInSection:),
        @selector(tableView:didEndDisplayingCell:forRowAtIndexPath:),
        @selector(tableView:willDisplayCell:forRowAtIndexPath:),
        @selector(tableView:estimatedHeightForRowAtIndexPath:),
        NULL
    };
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if (![self.target respondsToSelector:@selector(supportEstimatedHeight)]) {
        selectors[10] = NULL;
    }
#pragma clang diagnostic pop
    
    for (SEL *p = selectors; *p != NULL; ++p) {
        if (aSelector == *p) {
            retVal = YES;
            break;
        }
    }
    if (!retVal) {
        retVal = [self.target respondsToSelector:aSelector];
    }
    
    return retVal;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([tableView.dataSource conformsToProtocol:@protocol(ACYTableViewDataSource)]) {
        id <ACYTableViewDataSource> dataSource = (id)tableView.dataSource;
        
        ACYTableRow *row = [dataSource rowAtIndexPath:indexPath];
        
        if (row && [row respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [row tableView:tableView didSelectRowAtIndexPath:indexPath];
        }
    } else if (self.target && [self.target respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.target tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView.dataSource conformsToProtocol:@protocol(ACYTableViewDataSource)]) {
        id <ACYTableViewDataSource> dataSource = (id)tableView.dataSource;
        
        ACYTableRow *row = [dataSource rowAtIndexPath:indexPath];
        
        if (row && [row respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
            [row tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
        }
    }else if (self.target && [self.target respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.target tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView.dataSource conformsToProtocol:@protocol(ACYTableViewDataSource)]) {
        id<ACYTableViewDataSource> dataSource = (id)tableView.dataSource;
        
        ACYTableRow *row = [dataSource rowAtIndexPath:indexPath];
        
        if (row && [row respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
            [row tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
        }
    }else if (self.target && [self.target respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [self.target tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 60.0;
    
    if ([tableView.dataSource conformsToProtocol:@protocol(ACYTableViewDataSource)]) {
        id<ACYTableViewDataSource> dataSource = (id)tableView.dataSource;
        
        ACYTableRow *row = [dataSource rowAtIndexPath:indexPath];
        
        if (row.autoAdjustCellHeight) {
            height = [dataSource autoAdjustedCellHeightAtIndexPath:indexPath inTableView:tableView];
        } else {
            height = [[dataSource rowAtIndexPath:indexPath] cellHeight];
        }
    } else if (self.target && [self.target respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        height = [self.target tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *retVal = nil;
    
    if ([tableView.dataSource conformsToProtocol:@protocol(ACYTableViewDataSource)]) {
        id<ACYTableViewDataSource> dataSource = (id)tableView.dataSource;
        
        ACYTableSection *tableSection = [[dataSource allSections] objectAtIndex:section];
        
        retVal = [tableSection viewForHeaderInTableView:tableView section:section];
    } else if (self.target && [self.target respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        retVal = [self.target tableView:tableView viewForHeaderInSection:section];
    }
    
    return retVal;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *retVal = nil;
    
    if ([tableView.dataSource conformsToProtocol:@protocol(ACYTableViewDataSource)]) {
        id<ACYTableViewDataSource> dataSource = (id)tableView.dataSource;
        
        ACYTableSection *tableSection = [[dataSource allSections] objectAtIndex:section];
        
        retVal = [tableSection viewForFooterInTableView:tableView section:section];
    } else if (self.target && [self.target respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        retVal = [self.target tableView:tableView viewForFooterInSection:section];
    }
    
    return retVal;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 0.0;
    
    if ([tableView.dataSource conformsToProtocol:@protocol(ACYTableViewDataSource)]) {
        id<ACYTableViewDataSource> dataSource = (id)tableView.dataSource;
        
        ACYTableSection *tableSection = [[dataSource allSections] objectAtIndex:section];
        
        height = [tableSection heightForHeaderInTableView:tableView inSection:section];
    } else if (self.target && [self.target respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        height = [self.target tableView:tableView heightForHeaderInSection:section];
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 0.0;
    
    if ([tableView.dataSource conformsToProtocol:@protocol(ACYTableViewDataSource)]) {
        id<ACYTableViewDataSource> dataSource = (id)tableView.dataSource;
        
        ACYTableSection *tableSection = [[dataSource allSections] objectAtIndex:section];
        
        height = [tableSection heightForFooterInTableView:tableView inSection:section];
    } else if (self.target && [self.target respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        height = [self.target tableView:tableView heightForFooterInSection:section];
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    
    if ([tableView.dataSource conformsToProtocol:@protocol(ACYTableViewDataSource)]) {
        id<ACYTableViewDataSource> dataSource = (id)tableView.dataSource;
        ACYTableRow *row = [dataSource rowAtIndexPath:indexPath];
        
        if ([row respondsToSelector:@selector(estimatedHeight)]) {
            height = [row estimatedHeight];
        }
        
        if (height <= 0.0f) {
            height = row.cellHeight;
        }
    } else if (self.target && [self.target respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
        height = [self.target tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([tableView.dataSource conformsToProtocol:@protocol(ACYTableViewDataSource)]) {
        id<ACYTableViewDataSource> dataSource = (id)tableView.dataSource;
        
        ACYTableSection *tableSection = [[dataSource allSections] objectAtIndex:section];
        
        [tableSection tableView:tableView willDisplayHeaderView:view forSection:section];
    } else if (self.target && [self.target respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [self.target tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([tableView.dataSource conformsToProtocol:@protocol(ACYTableViewDataSource)]) {
        id<ACYTableViewDataSource> dataSource = (id)tableView.dataSource;
        ACYTableSection *tableSection = [[dataSource allSections] objectAtIndex:section];
        [tableSection tableView:tableView willDisplayFooterView:view forSection:section];
    } else {
        [self.target tableView:tableView willDisplayFooterView:view forSection:section];
    }
}

@end
