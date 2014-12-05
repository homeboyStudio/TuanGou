//
//  TGDock.h
//  点评团购
//
//  Created by homeboy on 14/11/20.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TGDock;
@protocol TGDockDelegate <NSObject>
@optional
- (void)dock:(TGDock *)dock tabChangeForm:(int)from to:(int)to;
@end
@interface TGDock : UIView
@property (nonatomic,weak)id<TGDockDelegate>delegate;
@end
