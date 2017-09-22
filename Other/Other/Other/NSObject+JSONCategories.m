//
//  NSObject+JSONCategories.m
//  MyFriends
//
//  Created by 杨剑 on 16/4/18.
//  Copyright © 2016年 zdksii. All rights reserved.
//

#import "NSObject+JSONCategories.h"

@implementation NSObject (JSONCategories)

/**
 *  NSboject 对象转换 成为Json内容格式的Data
 *
 *  @return NSData
 */
-(NSData*)JSONData
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

/**
 *  NSboject 对象转换 成为Json字符串
 *
 *  @return NSString
 */
-(NSString*)JSONString
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    NSString *jsonStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    return jsonStr;
}
@end
