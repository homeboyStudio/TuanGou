//
//  TGMerchantController.m
//  点评团购
//
//  Created by homeboy on 14/12/1.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGMerchantController.h"

@interface TGMerchantController ()

@end

@implementation TGMerchantController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x- 350, self.view.center.y, 300, 200)];
    label.text = @"此模块同团购简介一样实现";
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
