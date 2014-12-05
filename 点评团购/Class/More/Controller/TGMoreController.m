//
//  TGMoreController.m
//  点评团购
//
//  Created by homeboy on 14/11/22.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGMoreController.h"

@implementation TGMoreController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"更多";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"意见反馈" style:UIBarButtonItemStyleDone target:self action:nil];
 
}
- (void)done
{
    [self dismissViewControllerAnimated:YES completion:^{
        _moreItem.enabled = YES;
    }];
}
@end
