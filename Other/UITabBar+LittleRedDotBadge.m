//
//  UITabBar+LittleRedDotBadge.m
//  MyFriends
//
//  Created by 杨剑 on 16/5/17.
//  Copyright © 2016年 zdksii. All rights reserved.
//

#import "UITabBar+LittleRedDotBadge.h"

@implementation UITabBar (LittleRedDotBadge)
/**
 *  显示小红点
 *
 *  @param index 表示第几个ITEM ，0表示第一个
 */
- (void)showBadgeOnItemIndex:(int)index{
    
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 8, 8);
    badgeView.layer.cornerRadius = badgeView.frame.size.width/2;
    
    [self addSubview:badgeView];
    
}
/**
 *  隐藏小红点
 *
 *  @param index 表示第几个ITEM ，0表示第一个
 */
- (void)hideBadgeOnItemIndex:(int)index{
    
    //移除小红点
    [self removeBadgeOnItemIndex:index];
    
}

- (void)removeBadgeOnItemIndex:(int)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}
@end
