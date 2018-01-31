//
//  ACYTableViewDelegateProxy.h
//  ACYTableViewWrapper
//
//  Created by CambriaYang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Catch delegate method for `ACYTableViewDataSource`
 */
@interface ACYTableViewDelegateProxy : NSProxy <UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak, nullable) id target;

@end

NS_ASSUME_NONNULL_END
