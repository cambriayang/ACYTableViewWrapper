//
//  ACYTableRowCellTrack.h
//  webApp
//
//  Created by 黄庆 on 2017/9/22.
//  Copyright © 2017年 lufax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACYTableRow.h"

@protocol ACYTableRowCellTrack <NSObject>

@optional
- (void)trackWithRow:(ACYTableRow*)row indexPath:(NSIndexPath*)indexPath additionalInfo:(NSDictionary*)info;

@end
