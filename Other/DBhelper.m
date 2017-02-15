//
//  DBhelper.m
//  PocketInvoice
//
//  Created by BHI GPS on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DBhelper.h"
#import "AppDelegate.h"

@implementation DBhelper
//查找
+(NSMutableArray*)searchBy:(NSString*)ModelEmptyName;
{
	AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; // get the main app delegate
	NSManagedObjectContext* context = [appDelegate.persistentContainer viewContext]; // get the context in app delegate
	
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
	NSEntityDescription* entityDesc = [NSEntityDescription entityForName:ModelEmptyName inManagedObjectContext:context]; // generate a description that describe which entity in data model you want to handle.
	[request setEntity:entityDesc]; // assign the description to the request
	
	NSError* error;
	NSArray* objects = [context executeFetchRequest:request error:&error]; // all needed are prepared, then execute it.
	NSMutableArray* mutableObjects = [NSMutableArray arrayWithArray:objects];	
	return mutableObjects;
}
///name 搜索条件名称或者模型的名称  ， obj 继承与NSManagedObject的类的对象，也就是模型对象   ，  ModelKeyName 字段名称或者是关系名称
+(NSMutableArray*)SearchByTemplateWithName:(NSString*)Name  withValue:(id)obj  with:(NSString*)ModelKeyName
{
	AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];// get the main app delegate
	NSManagedObjectContext* context = [appDelegate.persistentContainer viewContext]; // get the context in app delegate
	
	NSDictionary * subVariables = [NSDictionary dictionaryWithObjectsAndKeys:obj,ModelKeyName,nil];
	NSFetchRequest* request = [appDelegate.persistentContainer.managedObjectModel fetchRequestFromTemplateWithName:Name substitutionVariables:subVariables];
	NSError* error;
	
	NSArray* objects = [context executeFetchRequest:request error:&error]; // all needed are prepared, then execute it.
	NSMutableArray* mutableObjects = [NSMutableArray arrayWithArray:objects];
	return mutableObjects;
}
+(NSMutableArray*)SearchByTemplateWithName:(NSString*)Name withKeyValuess:(NSDictionary*)subs
{
	AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];// get the main app delegate
	NSManagedObjectContext* context = [appDelegate.persistentContainer viewContext]; // get the context in app delegate
    
	NSFetchRequest *request = [appDelegate.persistentContainer.managedObjectModel fetchRequestFromTemplateWithName:Name substitutionVariables:subs];
	NSError* error;
	
	NSArray* objects = [context executeFetchRequest:request error:&error]; // all needed are prepared, then execute it.
	NSMutableArray* mutableObjects = [NSMutableArray arrayWithArray:objects];
	return mutableObjects;
}
//删除

+(NSMutableArray*)deleteBy:(NSMutableArray *)array withObj:(NSObject*)obj
{
    int index=(int)[array indexOfObject:obj];
    return [DBhelper deleteBy:array withIndex:index];
}

+(NSMutableArray*)deleteBy:(NSMutableArray*)array withIndex:(int)index
{
	AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext* context = [appDelegate.persistentContainer viewContext];
    
	id temp=[array objectAtIndex:index];
    [array removeObjectAtIndex:index];
	[context deleteObject:temp];
	
	NSError* error = nil;
	if (![context save:&error]) 
	{
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
	
	return array;
}
+(void)deleteBy:(id)obj
{
	
	AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext* context = [appDelegate.persistentContainer viewContext];
	
	[context deleteObject:obj];
	
	NSError* error = nil;
	if (![context save:&error]) 
	{
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
}
//插入
+(id)insertOrUpdateBy:(id)obj withEmpty:(NSString*)ModelEmptyName;
{
	AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext* context = [appDelegate.persistentContainer viewContext];
	
	
	if (obj == nil) {
		obj = [NSEntityDescription insertNewObjectForEntityForName:ModelEmptyName inManagedObjectContext:context];
	}
	
	
	return obj;
}
+(Boolean)Save
{
	AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext* context = [appDelegate.persistentContainer viewContext];
	
	NSError* error = nil;
	
	if (![context save:&error]) 
	{
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		return NO;
	}
	return YES;
}
+(NSMutableArray*)insertBy:(NSMutableArray*)array withEmpty:(id)obj//在调用前必须调用+(NSMutableArray*)deleteBy:(NSMutableArray*)array withIndex:(int)index;
{
	[array addObject:obj];
	return array;
}

//修改
+(NSMutableArray*)updateBy:(NSMutableArray*)array withEmpty:(id)obj withIndex:(int)index//在调用前必须调用+(NSMutableArray*)deleteBy:(NSMutableArray*)array withIndex:(int)index;
{
	[array replaceObjectAtIndex:index withObject:obj];
	return array;
}
@end
