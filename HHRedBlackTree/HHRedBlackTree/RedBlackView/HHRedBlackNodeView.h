//
//  HHBlackRedNodeView.h
//  HelloRedBlackTree
//
//  Created by DoubleH on 16/3/19.
//  Copyright © 2016年 DoubleH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHRedBlackNode.h"

static const float kRedBlackNodeViewWidth = 30;

@interface HHRedBlackNodeView : UIView

@property (nonatomic, strong, readonly) HHRedBlackNode *node;

- (void)updateWithNode:(HHRedBlackNode *)node;

+ (HHRedBlackNodeView *)viewWithNode:(HHRedBlackNode *)node;

@end
