//
//  HHBlackRedNodeView.m
//  HelloRedBlackTree
//
//  Created by DoubleH on 16/3/19.
//  Copyright © 2016年 DoubleH. All rights reserved.
//

#import "HHRedBlackNodeView.h"
#import "TKCommonTools.h"
#import "UIView+Utils.h"



@interface HHRedBlackNodeView ()

@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation HHRedBlackNodeView

+ (HHRedBlackNodeView *)viewWithNode:(HHRedBlackNode *)node {
    HHRedBlackNodeView *nodeView = [[HHRedBlackNodeView alloc] init];
    [nodeView updateWithNode:node];
    return nodeView;
}

- (instancetype)init {
    if (self = [super initWithFrame:CGRectMake(0, 0, kRedBlackNodeViewWidth, kRedBlackNodeViewWidth)]) {
        self.layer.cornerRadius = self.width * .5;
        self.clipsToBounds = YES;
        
        self.valueLabel = TKTemplateLabel([UIFont boldSystemFontOfSize:12], [UIColor whiteColor]);
        [self addSubview:self.valueLabel];
    }
    return self;
}

- (void)updateWithNode:(HHRedBlackNode *)node {
    _node = node;
    
    self.backgroundColor = node.isRed ? [UIColor redColor] : [UIColor blackColor];
    self.valueLabel.text = [node description];
    [self.valueLabel sizeToFit];
    if (self.valueLabel.width > self.width) {
        self.valueLabel.width = self.width;
    }
    self.valueLabel.centerX = self.width * .5;
    self.valueLabel.centerY = self.height * .5;
    [self addSubview:self.valueLabel];
}

@end
