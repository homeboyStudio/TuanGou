//
//  TGDetailDock.h
//  点评团购
//
//  Created by homeboy on 14/12/1.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TGDetailDockItem,TGDetailDock;
//详细控制器的代理协议
@protocol TGDetailDockDelegate<NSObject>
@optional
- (void)detailDock:(TGDetailDock * )detailDock btnClickFrom:(int)from to:(int)to;
@end
//TGDetailDock类
@interface TGDetailDock : UIView
@property (weak, nonatomic) IBOutlet TGDetailDockItem *infoBtn;
@property (weak, nonatomic) IBOutlet TGDetailDockItem *merchantBtn;
@property (weak,nonatomic)id<TGDetailDockDelegate>delegate;

+ (id)detailDock; 
- (IBAction)btnClick:(UIButton *)sender;

@end

//TGDetailDockItem类
@interface TGDetailDockItem : UIButton

@end
