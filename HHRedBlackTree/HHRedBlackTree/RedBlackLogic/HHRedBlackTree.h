//
//  HHRedBlackTree.h
//  HelloRedBlackTree
//
//  Created by DoubleH on 16/3/19.
//  Copyright © 2016年 DoubleH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHRedBlackNode.h"

@interface HHRedBlackTree : NSObject

- (BOOL)insertNode:(HHRedBlackNode *)node;

- (HHRedBlackNode *)rootNode;

- (NSUInteger)treeLevel;

@end
