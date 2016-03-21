//
//  HHRedBlackTreeView.m
//  HelloRedBlackTree
//
//  Created by DoubleH on 16/3/19.
//  Copyright © 2016年 DoubleH. All rights reserved.
//

#import "HHRedBlackTreeView.h"
#import "UIView+Utils.h"
#import "HHRedBlackTree.h"
#import "HHRedBlackNodeView.h"

static float const kNodeHorInterval = 50;

@interface HHRedBlackTreeView ()

@property (nonatomic, strong) HHRedBlackTree *rbTree;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation HHRedBlackTreeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.rbTree = [[HHRedBlackTree alloc] init];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self addSubview:self.scrollView];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self.scrollView addSubview:self.contentView];
        
        self.userInteractionEnabled = self.scrollView.userInteractionEnabled = YES;
        self.scrollView.scrollEnabled = YES;
    }
    return self;
}

- (BOOL)addNode:(HHRedBlackNode *)node {
    BOOL success = [self.rbTree insertNode:node];
    if (success) {
        [self updateView];
    }
    return success;
}

- (void)updateView {
    if (!self.rbTree.rootNode) {
        return;
    }
    [self.contentView removeAllSubviews];
    
    int treeLevel = (int)[self.rbTree treeLevel];
    CGFloat contentWidth = [self intervalWithLevel:0 totalLevel:treeLevel] * 2.0 + kRedBlackNodeViewWidth * 2.0;
    contentWidth = MAX(contentWidth, self.width);
    CGFloat contentHeight = contentWidth * .5;
    self.contentView.size = CGSizeMake(contentWidth, contentHeight);
    
    NSMutableArray *upperViews = [NSMutableArray array];
    HHRedBlackNodeView *nodeView = [HHRedBlackNodeView viewWithNode:self.rbTree.rootNode];
    nodeView.centerX = contentWidth * .5;
    [self.contentView addSubview:nodeView];
    [upperViews addObject:nodeView];
    
    int level = 1;
    float maxHeight = 0;
    while (upperViews.count) {
        NSMutableArray *tempViews = [NSMutableArray array];
        float interval = [self intervalWithLevel:level totalLevel:treeLevel];
        for (int i = 0; i < upperViews.count; ++i) {
            HHRedBlackNodeView *nodeView = upperViews[i];
            HHRedBlackNode *node = nodeView.node;
            if (node.leftSonNode) {
                HHRedBlackNodeView *leftView = [HHRedBlackNodeView viewWithNode:node.leftSonNode];
                leftView.centerY = nodeView.centerY + interval;
                leftView.centerX = nodeView.centerX - interval;
                [self.contentView addSubview:leftView];
                [tempViews addObject:leftView];
                
                UIView *line = [self lineWithLeft:YES interval:interval];
                line.centerX = (nodeView.centerX + leftView.centerX) * .5;
                line.centerY = (nodeView.centerY + leftView.centerY) * .5;
                [self.contentView insertSubview:line atIndex:0];
            }
            if (node.rightSonNode) {
                HHRedBlackNodeView *rightView = [HHRedBlackNodeView viewWithNode:node.rightSonNode];
                rightView.centerY = nodeView.centerY + interval;
                rightView.centerX = nodeView.centerX + interval;
                [self.contentView addSubview:rightView];
                [tempViews addObject:rightView];
                
                UIView *line = [self lineWithLeft:NO interval:interval];
                line.centerX = (nodeView.centerX + rightView.centerX) * .5;
                line.centerY = (nodeView.centerY + rightView.centerY) * .5;
                [self.contentView insertSubview:line atIndex:0];
            }
        }
        if (0 == tempViews.count) {
            for (HHRedBlackNodeView *view in upperViews) {
                maxHeight = MAX(view.bottom, maxHeight);
            }
        }
        upperViews = tempViews;
        ++level;
    }
    self.scrollView.contentSize = CGSizeMake(MAX(self.scrollView.width, contentWidth), MAX(self.scrollView.height, maxHeight + kRedBlackNodeViewWidth));
}

- (float)intervalWithLevel:(int)level totalLevel:(int)totalLevel {
    int count = powf(2, totalLevel - level - 1);
    float interval = MAX(count, 0) * kNodeHorInterval * .5;
    return interval;
}

- (UIView *)lineWithLeft:(BOOL)left interval:(float)interval {
    float width = 1.414 * interval;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
    line.backgroundColor = [UIColor grayColor];
    double angle = left ? -M_PI_4 : M_PI_4;
    line.transform = CGAffineTransformMakeRotation(angle);
    return line;
}

@end
