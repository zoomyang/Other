//
//  Exp.m
//  OrderingSystem
//
//  Created by issuser on 13-10-31.
//  Copyright (c) 2013年 Bestone. All rights reserved.
//

#import "Exp.h"

NSString* checkClassTypeAndtoString(NSDictionary *dic , NSString *key){
    id obj=[dic valueForKey:key]==[NSNull null]?@"":[dic valueForKey:key];
//    if ([dic valueForKey:key]==[NSNull null]) {
//        obj=@"";
//    }else{
//        obj=[dic valueForKey:key];
//    }
    if (![obj isKindOfClass:[NSString class]]) {
        return [obj stringValue];;
    }
    return obj;
}

NSObject* jkbself(id b){
    __block typeof(b)bself = b;
    return bself;
}

BOOL pointInRect(CGRect rect,CGPoint point)
{
    if (point.x>rect.origin.x&&point.x<rect.origin.x+rect.size.width) {
        if (point.y>rect.origin.y&&point.y<rect.origin.y+rect.size.height) {
            return YES;
        }
    }
    return NO;
}


@implementation Exp

@end
