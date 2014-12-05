//
//  TGCover.h
//  点评团购
//
//  Created by homeboy on 14/11/30.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  遮盖视图

#import <UIKit/UIKit.h>
@interface TGCover : UIView
@property (nonatomic,strong)NSString *title;
+ (id)cover;
//+ (id)coverWithTarget:(id)target action:(SEL)action;
//恢复透明度
- (void)resetAlpha;
@end
