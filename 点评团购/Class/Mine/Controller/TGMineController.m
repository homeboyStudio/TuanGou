//
//  TGMineController.m
//  点评团购
//
//  Created by homeboy on 14/11/22.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGMineController.h"

@implementation TGMineController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"退出登录" style:UIBarButtonItemStylePlain target:nil action:nil];
}
@end
