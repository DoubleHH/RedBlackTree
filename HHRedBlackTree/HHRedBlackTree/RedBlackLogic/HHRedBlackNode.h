//
//  HHRedBlackNode.h
//  HelloRedBlackTree
//
//  Created by DoubleH on 16/3/19.
//  Copyright © 2016年 DoubleH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHRedBlackNode : NSObject

//! 父节点
@property (nonatomic, strong) HHRedBlackNode *parentNode;
//! 左子节点
@property (nonatomic, strong) HHRedBlackNode *leftSonNode;
//! 右子节点
@property (nonatomic, strong) HHRedBlackNode *rightSonNode;
//! Node中的值，可以是任何类型
@property (nonatomic, strong) id value;
//! 是否是红色，默认为黑色
@property (nonatomic, assign) BOOL isRed;

/**
 *  是否是根节点
 *
 *  @return BOOL
 */
- (BOOL)isRootNode;

/**
 *  是否是叶子节点。注意：此叶子节点并非NULL节点，而是NULL节点的父节点
 *
 *  @return BOOL
 */
- (BOOL)isLeafNode;

/**
 *  用于比较的函数，如果value没有实现compare函数，需要子类重定义该方法
 *
 *  @param otherNode 另一Node
 *
 *  @return NSComparisonResult
 */
- (NSComparisonResult)compare:(HHRedBlackNode *)otherNode;

/**
 *  将本身转为叶子节点
 */
- (void)transferToLeafNode;

/**
 *  是否当前节点是父节点的左子节点
 *
 *  @return BOOL
 */
- (BOOL)isParentLeftNode;

/**
 *  父节点的另一子节点
 *
 *  @return HHRedBlackNode
 */
- (HHRedBlackNode *)parentOtherNode;

@end
