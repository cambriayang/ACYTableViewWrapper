//
//  ACYNode.m
//  ACYTableViewWrapper
//
//  Created by CambriaYang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import "ACYNode.h"

@implementation NSArray (ACYExtensions)

@dynamic count;

- (id)objectOrNilAtIndex:(NSUInteger)index {
    return [self containsIndex:index] ? [self objectAtIndex:index] : nil;
}

- (BOOL)containsIndex:(NSUInteger)index {
    return index < self.count;
}

@end

@interface ACYNode () {
    @private
    NSMutableArray <ACYNode *> *_children;
    NSArray <ACYNode *> *_unmutableChildren;
    __weak ACYNode *_parent;
}

@end

@implementation ACYNode

@dynamic children;
@dynamic parent;

- (void)setChildren:(NSArray <__kindof ACYNode *> *)children {
    if ([children isKindOfClass:[NSArray class]]) {
        _children = [NSMutableArray array];
        
        _unmutableChildren = [_children copy];
        
        for (ACYNode *node in children) {
            [self addChild:node];
        }
    } else {
        [_children removeAllObjects], _children = nil;
        
        _unmutableChildren = nil;
    }
}

- (NSArray <__kindof ACYNode *> *)children {
    return _unmutableChildren;
}

- (void)setParent:(ACYNode *)parent {
    if (_parent != parent) {
        _parent = parent;
    }
}

- (ACYNode *)parent {
    if (![_parent.children containsObject:self]) {
        _parent = nil;
    }
    
    return _parent;
}

- (void)addChild:(ACYNode *)node {
    if ([node isKindOfClass:[ACYNode class]]) {
        @synchronized (self) {
            node.parent = self;
            
            if (!_children) {
                _children = [NSMutableArray array];
            }
            
            [_children addObject:node];
            
            _unmutableChildren = [_children copy];
        }
    }
}

- (void)addChildFromArray:(NSArray <__kindof ACYNode *> *)array {
    if (array.count) {
        for (ACYNode *node in array) {
            [self addChild:node];
        }
    }
}

- (void)insertChild:(ACYNode *)node atIndex:(NSUInteger)index {
    if ([node isKindOfClass:[ACYNode class]]) {
        @synchronized (self) {
            node.parent = self;
            
            if (!_children) {
                _children = [NSMutableArray array];
            }
            
            [_children insertObject:node atIndex:index];
            
            _unmutableChildren = [_children copy];
        }
    }
}

- (void)removeChild:(ACYNode *)node {
    if ([node isKindOfClass:[ACYNode class]]) {
        @synchronized (self) {
            if ([_children containsObject:node]) {
                [_children removeObject:node];
                
                _unmutableChildren = [_children copy];
            }
        }
    }
}

- (void)removeAllChild {
    @synchronized (self) {
        [_children removeAllObjects], _children = nil;
        
        _unmutableChildren = nil;
    }
}

- (void)removeFromParent {
    [self.parent removeChild:self];
}

- (NSUInteger)nodeIndex {
    if (self.parent) {
        return [self.parent.children indexOfObject:self];
    }
    
    return NSNotFound;
}

- (ACYNode *)firstChild {
    return [self.children firstObject];
}

- (ACYNode *)lastChild {
    return [self.children lastObject];
}

- (NSArray <__kindof ACYNode *> *)siblings {
    if (self.parent == nil || self.nodeIndex == NSNotFound) {
        return nil;
    }
    
    NSMutableArray *array = [[self.parent children] mutableCopy];
    
    [array removeObject:self];
    
    return [array copy];
}

- (ACYNode *)previousSibling {
    NSArray *children = self.parent.children;
    
    NSInteger myIndex = [children indexOfObject:self];
    
    if (myIndex - 1 >= 0) {
        return children[myIndex - 1];
    }
    
    return nil;
}

- (ACYNode *)nextSibling {
    NSArray *children = self.parent.children;
    
    NSUInteger myIndex = [children indexOfObject:self];
    
    if (children.count > myIndex + 1) {
        return children[myIndex + 1];
    }
    
    return nil;
}

- (BOOL)isFirstChild {
    return [self.parent firstChild] == self;
}

- (BOOL)isLastChild {
    return [self.parent lastChild] == self;
}

- (NSUInteger)count {
    return [self.children count];
}

- (__kindof ACYNode *)objectAtIndex:(NSUInteger)idx {
    return self.children[idx];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])stackbuf
                                    count:(NSUInteger)len {
    return [self.children countByEnumeratingWithState:state objects:stackbuf count:len];
}

@end
