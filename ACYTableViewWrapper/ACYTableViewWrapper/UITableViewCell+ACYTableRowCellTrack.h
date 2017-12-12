//
//  UITableViewCell+ACYTableRowCellTrack.h
//  webApp
//
//  Created by 黄庆 on 2017/9/22.
//  Copyright © 2017年 lufax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACYTableRowCellTrack.h"

@interface UITableViewCell (ACYTableRowCellTrack) <ACYTableRowCellTrack>

- (void)trackWithRow:(ACYTableRow*)row indexPath:(NSIndexPath*)indexPath additionalInfo:(NSDictionary*)info;

@end
