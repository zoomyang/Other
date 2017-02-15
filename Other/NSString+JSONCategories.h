//
//  NSString+JSONCategories.h
//  MyFriends
//
//  Created by 杨剑 on 16/4/18.
//  Copyright © 2016年 zdksii. All rights reserved.
//

#import <Foundation/Foundation.h>

//来自这个博客  http://blog.sina.com.cn/s/blog_9564cb6e0101vvyt.html

@interface NSString (JSONCategories)
/**
 *  Json To Any Type
 *
 *  @return 返回任何类型 可以转换成 词典 或者 数组
 */
-(id)JSONValue;

- (NSString*) sha1;
@end
