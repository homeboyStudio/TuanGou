//
//  UIBarButtonItem+WB.h
//  新浪微博9.5
//
//  Created by homeboy on 14-9-14.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  将自定义barButton

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WB)
- (id)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted tagert:(id)tagert action:(SEL)action;
@end
