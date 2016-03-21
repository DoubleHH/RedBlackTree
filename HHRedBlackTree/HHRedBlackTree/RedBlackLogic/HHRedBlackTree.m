//
//  HHRedBlackTree.m
//  HelloRedBlackTree
//
//  Created by DoubleH on 16/3/19.
//  Copyright © 2016年 DoubleH. All rights reserved.
//

#import "HHRedBlackTree.h"

@interface HHRedBlackTree ()

@property (nonatomic, strong) HHRedBlackNode *rootNode;

@end

@implementation HHRedBlackTree

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (BOOL)isLegalNode:(HHRedBlackNode *)node {
    if (!node) {
        return NO;
    }
    if (!self.rootNode) {
        return YES;
    }
    return [self.rootNode isMemberOfClass:[node class]];
}

#pragma mark - Public Method
- (BOOL)insertNode:(HHRedBlackNode *)node {
    if (![self isLegalNode:node]) {
        return NO;
    }
    
    // make it red and change to leaf node
    node.isRed = YES;
    [node transferToLeafNode];
    
    // if no root node, then set node to root
    if (self.rootNode == nil) {
        node.isRed = NO;
        self.rootNode = node;
        return YES;
    }
    
    // find location with value and intert the node to tree
    HHRedBlackNode *interateNode = self.rootNode;
    while (true) {
        NSComparisonResult result = [node compare:interateNode];
        if (NSOrderedSame == result) {
            // if value same then insert failed
            return NO;
        }
        if (NSOrderedAscending == result) {
            if (interateNode.leftSonNode == nil) {
                interateNode.leftSonNode = node;
                node.parentNode = interateNode;
                break;
            }
            interateNode = interateNode.leftSonNode;
        }
        else {
            if (interateNode.rightSonNode == nil) {
                interateNode.rightSonNode = node;
                node.parentNode = interateNode;
                break;
            }
            interateNode = interateNode.rightSonNode;
        }
    }
    [self fixupNode:node];
    return YES;
}

- (BOOL)deleteNode:(HHRedBlackNode *)node {
    return YES;
}

- (BOOL)findNode:(HHRedBlackNode *)node {
    return YES;
}

- (HHRedBlackNode *)rootNode {
    return _rootNode;
}

- (NSUInteger)treeLevel {
    if (!self.rootNode) {
        return 0;
    }
    NSUInteger level = 0;
    NSMutableArray *nodes = [NSMutableArray arrayWithObjects:self.rootNode, nil];
    while (nodes.count) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (HHRedBlackNode *node in nodes) {
            if (node.leftSonNode) {
                [tempArray addObject:node.leftSonNode];
            }
            if (node.rightSonNode) {
                [tempArray addObject:node.rightSonNode];
            }
        }
        nodes = tempArray;
        ++level;
    }
    return level;
}

#pragma mark - Private Method
- (void)fixupNode:(HHRedBlackNode *)node {
    // 首先本身节点及父节点是红色才需要进行修复
    if (!node.isRed || !node.parentNode.isRed) {
        return;
    }
    //   case1      case2     case3
    //     H         H         H        --- 祖父节点
    //    / \       /         /
    //   R   R     R         R          --- 父节点
    //  / \ / \     \       /
    //    R(node)    R     R            --- 要处理的节点。为了表达清晰，相同数量的其他节点都可以清空掉
    
    while (true) {
        if ([node.parentNode isRootNode]) {
            self.rootNode = node.parentNode;
        }
        if (!node || !node.parentNode ||
            [node isRootNode] ||
            !node.isRed || !node.parentNode.isRed) {
            break;
        }
        HHRedBlackNode *otherNode = [node.parentNode parentOtherNode];
        if (otherNode && otherNode.isRed) {
            // case 1, 当父节点的兄弟节点存在，且节点是红色。且这种情况也只会出现再第一次步骤中，这是可以用假设法推论的
            node.parentNode.isRed = NO;
            otherNode.isRed = NO;
            node.parentNode.parentNode.isRed = YES;
            node = node.parentNode.parentNode;
        }
        else if (!otherNode || !otherNode.isRed) {
            // case 2, 当父节点的兄弟节点不存在，或是黑色。
            if ([node isParentLeftNode]) {                  // 在父节点的左边
                if ([node.parentNode isParentLeftNode]) {   // 父节点在祖父节点的左边
                    // case 3
                    node.parentNode.isRed = NO;
                    node.parentNode.parentNode.isRed = YES;
                    node = node.parentNode.parentNode;
                    [self rightRotateNode:node];
                }
                else {                                      // 父节点在祖父节点的右边
                    // case 2
                    node = node.parentNode;
                    [self rightRotateNode:node];
                }
            }
            else {                                          // 在父节点的右边
                if ([node.parentNode isParentLeftNode]) {   // 父节点在祖父节点的左边
                    // case 2
                    node = node.parentNode;
                    [self leftRotateNode:node];
                }
                else {                                      // 父节点在祖父节点的右边
                    // case 3
                    node.parentNode.isRed = NO;
                    node.parentNode.parentNode.isRed = YES;
                    node = node.parentNode.parentNode;
                    [self leftRotateNode:node];
                }
            }
        }
    }
    self.rootNode.isRed = NO;
}

- (void)leftRotateNode:(HHRedBlackNode *)node {
    if (!node || !node.rightSonNode) {
        return;
    }
    HHRedBlackNode *parentNode = node.parentNode;
    HHRedBlackNode *rightNode = node.rightSonNode;
    HHRedBlackNode *rightSonLeftNode = rightNode.leftSonNode;
    // make rightNode to parent son node
    if ([node isParentLeftNode]) {
        parentNode.leftSonNode = rightNode;
    } else {
        parentNode.rightSonNode = rightNode;
    }
    rightNode.parentNode = parentNode;
    // make current node to rightNode's left node
    rightNode.leftSonNode = node;
    node.parentNode = rightNode;
    // make rightSonLeftNode to node's right node
    node.rightSonNode = rightSonLeftNode;
    rightSonLeftNode.parentNode = node;
}

- (void)rightRotateNode:(HHRedBlackNode *)node {
    if (!node || !node.leftSonNode) {
        return;
    }
    HHRedBlackNode *parentNode = node.parentNode;
    HHRedBlackNode *leftNode = node.leftSonNode;
    HHRedBlackNode *leftSonRightNode = leftNode.rightSonNode;
    // make leftNode to parent son node
    if ([node isParentLeftNode]) {
        parentNode.leftSonNode = leftNode;
    } else {
        parentNode.rightSonNode = leftNode;
    }
    leftNode.parentNode = parentNode;
    // make current node to leftNode's right node
    leftNode.rightSonNode = node;
    node.parentNode = leftNode;
    // make leftNode's right node to node's left node
    node.leftSonNode = leftSonRightNode;
    leftSonRightNode.parentNode = node;
}

@end
