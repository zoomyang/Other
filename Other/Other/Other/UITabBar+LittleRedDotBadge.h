//
//  UITabBar+LittleRedDotBadge.h
//  MyFriends
//
//  Created by 杨剑 on 16/5/17.
//  Copyright © 2016年 zdksii. All rights reserved.
//





#import <UIKit/UIKit.h>

#define TabbarItemNums 4
/**
 *  UITabBar 小红点
 */
@interface UITabBar (LittleRedDotBadge)
/**
 *  显示小红点
 *
 *  @param index 表示第几个ITEM ，0表示第一个
 */
- (void)showBadgeOnItemIndex:(int)index;
/**
 *  隐藏小红点
 *
 *  @param index 表示第几个ITEM ，0表示第一个
 */
- (void)hideBadgeOnItemIndex:(int)index;
@end
