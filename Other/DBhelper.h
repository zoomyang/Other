//
//  DBhelper.h
//  PocketInvoice
//
//  Created by BHI GPS on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBhelper : NSObject {

}
//查找
+(NSMutableArray*)searchBy:(NSString*)ModelEmptyName;
///name 搜索条件名称或者模型的名称  ， obj 继承与NSManagedObject的类的对象，也就是模型对象   ，  ModelKeyName 字段名称或者是关系名称
+(NSMutableArray*)SearchByTemplateWithName:(NSString*)Name  withValue:(id)obj  with:(NSString*)ModelKeyName;
+(NSMutableArray*)SearchByTemplateWithName:(NSString*)Name withKeyValuess:(NSDictionary*)subs;
//删除
+(NSMutableArray*)deleteBy:(NSMutableArray *)array withObj:(NSObject*)obj;
+(NSMutableArray*)deleteBy:(NSMutableArray*)array withIndex:(int)index;
+(void)deleteBy:(id)obj;
//插入
+(id)insertOrUpdateBy:(id)obj withEmpty:(NSString*)ModelEmptyName;
+(Boolean)Save;



+(NSMutableArray*)insertBy:(NSMutableArray*)array withEmpty:(id)obj;//在调用前必须调用+(NSMutableArray*)deleteBy:(NSMutableArray*)array withIndex:(int)index;
//修改
+(NSMutableArray*)updateBy:(NSMutableArray*)array withEmpty:(id)obj withIndex:(int)index;//在调用前必须调用+(NSMutableArray*)deleteBy:(NSMutableArray*)array withIndex:(int)index;
@end
