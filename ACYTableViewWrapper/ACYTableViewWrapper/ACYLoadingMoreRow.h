//
//  ACYLoadingMoreRow.h
//  webApp
//
//  Created by yeyang on 2017/4/25.
//  Copyright © 2017年 lufax. All rights reserved.
//

#import "ACYTableRow.h"

@class ACYLoadingMoreCell;

NS_ASSUME_NONNULL_BEGIN

@interface ACYLoadingMoreRow : ACYTableRow

@property (nonatomic, weak, readonly) ACYLoadingMoreCell *cell;

@end

@interface ACYLoadingMoreCell : UITableViewCell

@end

NS_ASSUME_NONNULL_END
