//
//  NSObject+JSONCategories.h
//  MyFriends
//
//  Created by 杨剑 on 16/4/18.
//  Copyright © 2016年 zdksii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSONCategories)

/**
 *  NSboject 对象转换 成为Json内容格式的Data
 *
 *  @return NSData
 */
-(NSData*)JSONData;
/**
 *  NSboject 对象转换 成为Json字符串
 *
 *  @return NSString
 */
-(NSString*)JSONString;
@end
