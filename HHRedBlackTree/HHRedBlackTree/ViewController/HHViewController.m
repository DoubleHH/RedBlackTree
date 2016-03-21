//
//  HHViewController.m
//  HelloRedBlackTree
//
//  Created by DoubleH on 16/3/19.
//  Copyright © 2016年 DoubleH. All rights reserved.
//

#import "HHViewController.h"
#import "HHRedBlackTreeView.h"
#import "UIView+Utils.h"
#import "HHImageUtil.h"

@interface HHViewController ()

@property (nonatomic, strong) HHRedBlackTreeView *treeView;

@end

@implementation HHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.treeView = [[HHRedBlackTreeView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 30)];
    [self.view addSubview:self.treeView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.treeView.width - 100, [UIScreen mainScreen].bounds.size.height - 40, 80, 30)];
    [button setTitle:@"添加" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setBackgroundImage:HHRadiusImageWithColor([UIColor darkGrayColor], button.size, 6) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonPressed {
    int value = arc4random() % 1000;
    NSLog(@"准备添加 %d ", value);
    HHRedBlackNode *node = [[HHRedBlackNode alloc] init];
    node.value = [NSNumber numberWithInt:value];
    
    BOOL success = [self.treeView addNode:node];

    NSLog(@"添加 %d %@ ！", value, success ? @"成功" : @"失败");
}

@end
