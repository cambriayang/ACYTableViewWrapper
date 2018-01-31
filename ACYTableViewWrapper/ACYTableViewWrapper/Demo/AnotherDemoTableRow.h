//
//  AnotherDemoTableRow.h
//  ACYTableViewWrapper
//
//  Created by CambriaYang on 19/02/2017.
//  Copyright © 2017 yeio. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Masonry.h>

#import "ACYTableRow.h"

FOUNDATION_EXTERN NSString *const AnotherDemoTableRowAnimation;

@interface AnotherDemoTableRow : ACYTableRow

@end

@interface AnotherDemoTableViewCell : UITableViewCell

- (void)updateText:(ACYTableRowState)state;

@end
