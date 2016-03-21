//
//  HHRedBlackNode.m
//  HelloRedBlackTree
//
//  Created by DoubleH on 16/3/19.
//  Copyright © 2016年 DoubleH. All rights reserved.
//

#import "HHRedBlackNode.h"

@implementation HHRedBlackNode

- (BOOL)isRootNode {
    return (self.parentNode == nil);
}

- (BOOL)isLeafNode {
    return (self.leftSonNode == nil && self.rightSonNode == nil);
}

- (NSComparisonResult)compare:(HHRedBlackNode *)otherNode {
    return [self.value compare:otherNode.value];
}

- (void)transferToLeafNode {
    self.leftSonNode = nil;
    self.rightSonNode = nil;
}

- (BOOL)isParentLeftNode {
    if (!self.parentNode) {
        return NO;
    }
    return (self.parentNode.leftSonNode == self);
}

- (HHRedBlackNode *)parentOtherNode {
    if ([self isParentLeftNode]) {
        return self.parentNode.rightSonNode;
    }
    return self.parentNode.leftSonNode;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", self.value];
}

@end
