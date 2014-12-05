//
//  TGInfoTextView.h
//  点评团购
//
//  Created by homeboy on 14/12/2.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  商家团购详情详情

#import <UIKit/UIKit.h>

@interface TGInfoTextView : UIView
@property (weak, nonatomic) IBOutlet UIButton *titleView;
@property (weak, nonatomic) IBOutlet UILabel *contentView;

//重写set方法
@property (nonatomic,copy)NSString *icon;  //图标
@property (nonatomic,copy)NSString *title; //标题
@property (nonatomic,copy)NSString *content; //内容

+ (id)infoTextView;
@end
