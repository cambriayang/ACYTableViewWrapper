//
//  ACYNode.h
//  ACYTableViewWrapper
//
//  Created by CambriaYang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * DTExtensions for reading value at index
 */
@interface NSArray (ACYExtensions)

@property(nonatomic, readonly, assign) NSUInteger count;

- (id)objectOrNilAtIndex:(NSUInteger)index;

- (BOOL)containsIndex:(NSUInteger)index;

@end

@interface ACYNode : NSObject <NSFastEnumeration>

@property (nonatomic, weak) __kindof ACYNode *parent;
@property (nonatomic, strong) __kindof NSArray <__kindof ACYNode *> *children;

- (void)addChild:(__kindof ACYNode *)node;

- (void)addChildFromArray:(NSArray <__kindof ACYNode *> *)array;

- (void)insertChild:(__kindof ACYNode *)node atIndex:(NSUInteger)index;

- (void)removeChild:(__kindof ACYNode *)node;

- (void)removeFromParent;

- (void)removeAllChild;

- (NSUInteger)nodeIndex;

- (__kindof ACYNode *)firstChild;

- (__kindof ACYNode *)lastChild;

- (NSArray <__kindof ACYNode *> *)siblings;

- (BOOL)isLastChild;

- (BOOL)isFirstChild;

- (__kindof ACYNode *)nextSibling;

- (__kindof ACYNode *)previousSibling;

- (NSUInteger)count;

- (__kindof ACYNode *)objectAtIndex:(NSUInteger)idx;

@end

NS_ASSUME_NONNULL_END
