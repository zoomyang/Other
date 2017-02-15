//
//  BHI_Utility.m
//
//  Created by Joe Jia on 3/31/10.
//  Copyright 2010 BHI Technologies, Inc. All rights reserved.
//

#import "BHI_Utility.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "AppDelegate.h"
#import "GTMBase64.h"

//引入IOS自带密码库
#import <CommonCrypto/CommonCryptor.h>
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";//设置编码

@implementation BHI_Utility

+(NSNumber*)getMusicItemIdFromString:(NSString*)string
{
	unsigned long long value = strtoull([string UTF8String], NULL, 0);
	NSNumber* musicId = [NSNumber numberWithUnsignedLongLong:value];

	return musicId;
}

+(NSString*)getStringFromMusicItemId:(NSNumber*)number
{
	unsigned long long value = [number unsignedLongLongValue];
	NSString* str = [NSString stringWithFormat:@"%llu", value];
	
	return str;
}

+(NSURL*)urlFromSetting
{
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *plistPath = [bundle pathForResource:
						   @"settings" ofType:@"plist"];
	NSDictionary* setting = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	
	NSDictionary* pushNews = [setting objectForKey:@"PushNews"];
	NSString* urlStr = [pushNews objectForKey:@"URL"];
	NSURL* url = [NSURL URLWithString:urlStr];
	
	return url;
}

+(NSString*)getMessageFromError:(NSError*)error
{
	return @"error";
}


+ (NSString*) stringWithUUID {
	CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
	//get the string representation of the UUID
	NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
	CFRelease(uuidObj); 
	return uuidString;
}

+(NSString *)screenType
{
    CGSize screensize = [[UIScreen mainScreen] bounds].size;
    if (screensize.width==320&&screensize.height==568) {
        return @"ip5";
    }else if (screensize.width==375&&screensize.height==667){
        return @"ip6";
    }else if (screensize.width==414&&screensize.height==763){
        return @"ip6p";
    }
    
    return @"ip6p";
}

@end


@implementation UIColor (BHI_Extensions)
-(float)getRed
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
   
    return components[0];
}

-(float)getGreen
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    return components[1];
}

-(float)getBlue
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    return components[2];
}
@end


static NSCalendar *calendar;
static NSDateFormatter* outputFormatter;
@implementation NSDate (BHI_Extensions)



//-(id) init
//{
//	calendar=[NSCalendar currentCalendar]; 
//	return self;
//}
+(NSCalendar*)getCalendar
{
	if (calendar==nil) {
		//calendar=[NSCalendar currentCalendar]; 
		calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSLocaleCalendar];
	}
	return calendar;	
}

+(NSDateFormatter*)getOutputFormatter
{	
	if (outputFormatter==nil) {
		outputFormatter = [[NSDateFormatter alloc] init];
	}
	return outputFormatter;
}
-(NSString*)stringFromFormat:(NSString*)dateFormat
{	
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:dateFormat];
	
	NSString* retStr = [formatter stringFromDate:self];
	return retStr;
}

-(BOOL)isBetweenDateFrom:(NSDate*)dateFrom to:(NSDate*)dateTo
{
	NSTimeInterval intervalFrom = [dateFrom timeIntervalSince1970];
	NSTimeInterval intervalTo = [dateTo timeIntervalSince1970];
	
	if (intervalFrom > intervalTo)
	{
		NSTimeInterval temp = intervalTo;
		intervalTo = intervalFrom;
		intervalFrom = temp;
	}
	
	NSTimeInterval selfInterval = [self timeIntervalSince1970];
	if (intervalFrom <= selfInterval && selfInterval <= intervalTo)
	{
		return YES;
	}
	else {
		return NO;
	}
}


-(NSDate*)getStartDate
{
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSLocaleCalendar];
	NSInteger year = [[gregorian components:NSCalendarUnitYear fromDate:self] year];
	NSInteger month = [[gregorian components:NSCalendarUnitMonth fromDate:self] month];
	NSInteger day = [[gregorian components:NSCalendarUnitDay fromDate:self] day];
	
	NSDateComponents* dc = [[NSDateComponents alloc] init];
	[dc setDay:day];
	[dc setMonth:month];
	[dc setYear:year];
	[dc setHour:0];
	[dc setMinute:0];
	[dc setSecond:0];
	return [gregorian dateFromComponents:dc];
}

-(NSDate*)getEndDate
{
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSLocaleCalendar];
	NSInteger year = [[gregorian components:NSCalendarUnitYear fromDate:self] year];
	NSInteger month = [[gregorian components:NSCalendarUnitMonth fromDate:self] month];
	NSInteger day = [[gregorian components:NSCalendarUnitDay fromDate:self] day];
	
	NSDateComponents* dc = [[NSDateComponents alloc] init];
	[dc setDay:day];
	[dc setMonth:month];
	[dc setYear:year];
	[dc setHour:23];
	[dc setMinute:59];
	[dc setSecond:59];
	return [gregorian dateFromComponents:dc];
}
//获得周
-(NSDate*)getFirstDayInWeek;
{
	NSDateComponents* component = [[NSDate getCalendar] components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:self];
	[component setYear:component.year];
	[component setWeekOfYear:component.weekOfYear];
	[component setHour:0];
	[component setMinute:0];
	[component setSecond:0];
	
	return [[NSDate getCalendar] dateFromComponents:component];
}

-(NSDate*)getLastDayInWeek;
{
	NSDateComponents* component = [[NSDate getCalendar] components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:self];
	[component setYear:component.year];
	[component setWeekOfYear:component.weekOfYear + 1];
	[component setHour:0];
	[component setMinute:0];
	[component setSecond:0];
	
	NSDate* retDate = [[NSDate getCalendar] dateFromComponents:component];
	[component setSecond:-1];
	
	return [[NSDate getCalendar] dateByAddingComponents:component toDate:retDate options:0];
}

//获得月
-(NSDate*)getFirstDayInMonth
{
	NSDateComponents* component = [[NSDate getCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:self];
	[component setYear:component.year];
	[component setMonth:component.month];
	[component setHour:0];
	[component setMinute:0];
	[component setSecond:0];
	
	return [calendar dateFromComponents:component];
}

-(NSDate*)getLastDayInMonth
{
	NSDateComponents* component = [[NSDate getCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:self];
	[component setYear:component.year];
	[component setMonth:component.month + 1];
	[component setHour:0];
	[component setMinute:0];
	[component setSecond:0];
	
	NSDate* retDate = [[NSDate getCalendar] dateFromComponents:component];
	[component setSecond:-1];
	
	return [[NSDate getCalendar] dateByAddingComponents:component toDate:retDate options:0];
}
//获得季度
-(NSDate*)getFirstDayInQuarter
{
	NSDateComponents* component = [[NSDate getCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
	[component setYear:component.year];

	if (ceil(component.month*1.0/3)==1) {
		[component setMonth:1];
	}else if (ceil(component.month*1.0/3)==2)
	{
		[component setMonth:4];
	}
	else if(ceil(component.month*1.0/3)==3)
	{
		[component setMonth:7];
	}
	else if(ceil(component.month*1.0/3)==4)
	{
		[component setMonth:10];
	}
	[component setDay:1];
	[component setHour:0];
	[component setMinute:0];
	[component setSecond:0];
	
	return [[NSDate getCalendar] dateFromComponents:component];
}
-(NSDate*)getLastDayInQuarter
{
	NSDateComponents* component = [[NSDate getCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
	[component setYear:component.year];
	if (ceil(component.month*1.0/3)==1) {
		[component setMonth:4];
	}else if(ceil(component.month*1.0/3)==2)
	{
		[component setMonth:7];
	}
	else if(ceil(component.month*1.0/3)==3)
	{
		[component setMonth:10];
	}
	else if(ceil(component.month*1.0/3)==4)
	{
		[component setYear:component.year+1];
		[component setMonth:1];
	}
	[component setDay:1];
	[component setHour:0];
	[component setMinute:0];
	[component setSecond:0];
	
	NSDate* retDate = [[NSDate getCalendar] dateFromComponents:component];
	[component setSecond:-1];
	
	return [calendar dateByAddingComponents:component toDate:retDate options:0];
}
//获得年
-(NSDate*)getFirstDayInYear
{
	NSDateComponents* component = [[NSDate getCalendar] components:NSCalendarUnitYear fromDate:self];
	[component setYear:component.year];
	[component setHour:0];
	[component setMinute:0];
	[component setSecond:0];
	
	return [calendar dateFromComponents:component];
}
-(NSDate*)getLastDayInYear
{
	NSDateComponents* component = [[NSDate getCalendar] components:NSCalendarUnitYear fromDate:self];
	[component setYear:component.year+1];
	[component setHour:0];
	[component setMinute:0];
	[component setSecond:0];
	
	NSDate* retDate = [[NSDate getCalendar] dateFromComponents:component];
	[component setSecond:-1];
	
	return [[NSDate getCalendar] dateByAddingComponents:component toDate:retDate options:0];
}

-(NSDate*)getTimeInDay
{
	NSDateComponents* component = [[NSDate getCalendar] components:NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitMonth fromDate:self];
	[component setYear:component.year];
	[component setMonth:component.month];
	[component setDay:component.day];
	[component setHour:0];
	[component setMinute:0];
	[component setSecond:0];
	
	return [[NSDate getCalendar] dateFromComponents:component];
}

-(NSDate*)getDateNoSeconds
{
	NSDateComponents* component = [[NSDate getCalendar] components:NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self];
	[component setYear:component.year];
	[component setMonth:component.month];
	[component setDay:component.day];
	[component setHour:component.hour];
	[component setMinute:component.minute];
	[component setSecond:0];
	
	return [calendar dateFromComponents:component];
}

-(float)getSecondsSinceStartDay
{
	return [self timeIntervalSinceDate: [[NSDate date] getStartDate]];
}

-(NSDate*)getDateWithAddSeconds:(long)seconds
{
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSLocaleCalendar];
	NSDateComponents* dc = [[NSDateComponents alloc] init];
	[dc setSecond:seconds];
	NSDate *date=[gregorian dateByAddingComponents:dc toDate:self options:0];
	return date;
}



-(int)dateComparewithDate:(NSDate *)dt2  //0 dt1=dt2 -1 dt1<dt2 1 dt1>dt2
{
    
	NSDateComponents *cmpday1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
	NSDateComponents *cmpday2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dt2];
	if([cmpday1 day] == [cmpday2 day] &&
	   [cmpday1 month] == [cmpday2 month] &&
	   [cmpday1 year] == [cmpday2 year]) {
		return Equal;
	}
	
	if([cmpday1 year] > [cmpday2 year]) return Asc;
	if([cmpday1 year] == [cmpday2 year]&&[cmpday1 month] > [cmpday2 month]) return Asc;
	if([cmpday1 year] == [cmpday2 year]&&[cmpday1 month] ==[cmpday2 month]&&[cmpday1 day] > [cmpday2 day]) return Asc;
	
	return Desc;
	
}
//时间格式化 date时间 style样式 
//type == 1: 根据时区改变
//type == 2: 固定样式
- (NSString *)formatterDatestyle:(NSString *)style type:(NSInteger)type
{		
	if(type == 1)
		[[NSDate getOutputFormatter] setDateFormat:[NSDateFormatter dateFormatFromTemplate:style options:0 locale:[NSLocale currentLocale]]];
	else if(type == 2)
		[[NSDate getOutputFormatter] setDateFormat:style];
	
	return [[NSDate getOutputFormatter] stringFromDate:self];
}

-(NSString*)getDateFormateWithDateShow:(BOOL)dateShow  withTimeShow:(BOOL)timeShow
{
	
	if (dateShow==YES) {
		[[NSDate getOutputFormatter] setDateStyle:NSDateFormatterMediumStyle];
	}
	if (timeShow==YES) {
		[[NSDate getOutputFormatter] setTimeStyle:NSDateFormatterShortStyle];
	}
	
	NSString* time = [outputFormatter stringFromDate:self];
	//[outputFormatter release];
	return time;
}

//字符串转日期
+(NSDate*)formatterDate:(NSString *)style withDate:(NSString*)dateStr
{
//    if(type == 1)
//		[[NSDate getOutputFormatter] setDateFormat:[NSDateFormatter dateFormatFromTemplate:style options:0 locale:[NSLocale currentLocale]]];
//	else if(type == 2)
		   [[NSDate getOutputFormatter] setDateFormat:style];
    
    return [[NSDate getOutputFormatter] dateFromString:dateStr];
}

+ (NSDate * )stringToNSDate: (NSString * )dateStr withFormat:(NSString*)format
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: format];
    NSDate *date = [formatter dateFromString :dateStr];
    return date;
}

//计算两个日期之间的差距，过了多少天。。
+(NSInteger)getDateToDateDays:(NSDate *)date withSaveDate:(NSDate *)saveDate{
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSLocaleCalendar ];
    NSUInteger unitFlags =  NSCalendarUnitHour | NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cps = [ chineseClendar components:unitFlags fromDate:date  toDate:saveDate  options:0];
    NSInteger diffDay   = [ cps day ];
    return diffDay;
}



@end

#pragma mark - NSString

@implementation NSString (BHI_Extensions)

-(float)getStringHightfont:(UIFont*)font
{
    CGSize size;
//    if (is_ios_7) {
        NSDictionary *attributes = @{NSFontAttributeName: font};
        size= [self sizeWithAttributes:attributes];
//    }else{
//        size=[self sizeWithFont:font];
//        
//    }
    
    return size.height;
}

-(float)getStringWidthfont:(UIFont*)font
{
    CGSize size;
//    if (is_ios_7) {
        NSDictionary *attributes = @{NSFontAttributeName: font};
        size= [self sizeWithAttributes:attributes];
//    }else{
//        size=[self sizeWithFont:font];
//        
//    }
    return size.width;
}

-(NSString*)stringWithInt:(int)intNumber
{
    return [NSString stringWithFormat:@"%d",intNumber];
}
-(NSString*)stringWithFloat2:(float)floadNumber2
{
    return [NSString stringWithFormat:@"%.2f",floadNumber2];
}
-(NSString*)stringwithDouble2:(double)doubleNumber2
{
    return [NSString stringWithFormat:@"%.2f",doubleNumber2];
}

-(NSData *)utf8
{
   return  [self dataUsingEncoding:NSUTF8StringEncoding];
}


//利用正则表达式验证邮箱
-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:self];
}
/**
 *  判断手机号码
 *
 *  @return 返回null表示是手机号码
 */
- (NSString *)valiMobile {
    
    if (self.length < 11) {
        return @"手机号长度只能是11位";
    } else {
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:self];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:self];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:self];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        } else {
            return @"请输入正确的电话号码";
        }
    }
    
    return nil;
}

+ (CGFloat)heightOfText:(NSString *)text theWidth:(float)width theFont:(UIFont*)aFont {
    CGFloat result;
    CGSize textSize = { width, 20000.0f };
    
//    CGSize size = [text sizeWithFont:aFont constrainedToSize:textSize lineBreakMode:NSLineBreakByWordWrapping];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attributes = @{NSFontAttributeName: aFont, NSParagraphStyleAttributeName: style};
    CGSize size = [text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    
    result = size.height;
    return result;
}
@end

@implementation NSString (base64)


#pragma mark - base64  解码 成为 NSData
//base64编码  to NSdata    反编码调用 base64EncodingCustom
//- (NSData*)dataWithBase64EncodedStringCustom
//{
//    
//	if (self == nil)
//		[NSException raise:NSInvalidArgumentException format:@""];
//	if ([self length] == 0)
//		return [NSData data];
//	
//	static char *decodingTable = NULL;
//	if (decodingTable == NULL)
//	{
//		decodingTable = malloc(256);
//		if (decodingTable == NULL)
//			return nil;
//		memset(decodingTable, CHAR_MAX, 256);
//		NSUInteger i;
//		for (i = 0; i < 64; i++)
//			decodingTable[(short)encodingTable[i]] = i;
//	}
//	const char *characters = [self cStringUsingEncoding:NSASCIIStringEncoding];
//	if (characters == NULL)     //  Not an ASCII string!
//		
//		return nil;
//	char *bytes = malloc((([self length] + 3) / 4) * 3);
//	if (bytes == NULL)
//		return nil;
//	NSUInteger length = 0;
//	
//	NSUInteger i = 0;
//	while (YES)
//	{
//		char buffer[4];
//		short bufferLength;
//		for (bufferLength = 0; bufferLength < 4; i++)
//		{
//			if (characters[i] == '\0')
//				break;
//			if (isspace(characters[i]) || characters[i] == '=')
//				continue;
//			buffer[bufferLength] = decodingTable[(short)characters[i]];
//			if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
//			{
//				free(bytes);
//				return nil;
//			}
//		}
//		
//		if (bufferLength == 0)
//			break;
//		if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
//		{
//			free(bytes);
//			return nil;
//		}
//		
//		//  Decode the characters in the buffer to bytes.
//		bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
//		if (bufferLength > 2)
//			bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
//		if (bufferLength > 3)
//			bytes[length++] = (buffer[2] << 6) | buffer[3];
//	}
//	
//	realloc(bytes, length);
//	return [NSData dataWithBytesNoCopy:bytes length:length];
//}

//将base64 编码字符串 转化成 NSdata
+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:@""];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}


#pragma mark - NSString 的base64 编码 与解码
//空字符串
#define     LocalStr_None           @""

- (NSString *)base64StringFromText
{
    if (self && ![self isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY
        NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin
        data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [data base64EncodingCustom];
    }
    else {
        return LocalStr_None;
    }
}

- (NSString *)textFromBase64String
{
    if (self && ![self isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY
        NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        
        NSData *data =[GTMBase64 encodeData:[self dataUsingEncoding:NSUTF8StringEncoding]];
        //IOS 自带DES解密 Begin
        data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return LocalStr_None;
    }
}
#pragma mark -
/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
- (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
- (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}



@end

#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access
#pragma mark - MD5     MBBase64
@implementation NSString (MyExtensions)
- (NSString *) md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}
@end

@implementation NSData (MyExtensions)
- (NSString*)md5
{
    unsigned char result[16];
    CC_MD5( self.bytes, (CC_LONG)self.length, result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}
@end

@implementation NSData (MBBase64)

#pragma mark - NSData 编码 成为base64
//返回 base64编码 字符串    反编码调用 dataWithBase64EncodedStringCustom
- (NSString *)base64EncodingCustom;
{//调用base64的方法
	
	if ([self length] == 0)
		return @"";
	
    char *characters = malloc((([self length] + 2) / 3) * 4);
	
	if (characters == NULL)
		return nil;
	NSUInteger length = 0;
	
	NSUInteger i = 0;
	while (i < [self length])
	{
		char buffer[3] = {0,0,0};
		short bufferLength = 0;
		while (bufferLength < 3 && i < [self length])
			buffer[bufferLength++] = ((char *)[self bytes])[i++];
		//  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
		characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
		characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
		if (bufferLength > 1)
			characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
		else characters[length++] = '=';
		if (bufferLength > 2)
			characters[length++] = encodingTable[buffer[2] & 0x3F];
		else characters[length++] = '=';
	}
	
	return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}
//返回 base64编码 字符串
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

#pragma mark -
-(NSString*)stringUTF8
{
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end

#pragma mark -  UIImage

@implementation UIImage (Extens)

+ (UIImage *)image:(UIImage *)image rotate:(float)rotate
{
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    rect = CGRectMake(0, 0, image.size.width, image.size.height);
    translateX = 0;
    translateY = 0;

    rotate=2*rotate*M_PI;
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}
//压缩图片质量
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent
{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}

//改变 图像大小
- (UIImage *)transformToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//1.等比率缩放
- (UIImage *)transformToScale:(float)scaleSize
{
    
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
                                
    return scaledImage;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float radius, UIImageRoundedCorner cornerMask)
{
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    if (cornerMask & UIImageRoundedCornerTopLeft) {
        CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius,
                        radius, M_PI, M_PI / 2, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
        CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y + rect.size.height);
    }
    
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius,
                            rect.origin.y + rect.size.height);
    
    if (cornerMask & UIImageRoundedCornerTopRight) {
        CGContextAddArc(context, rect.origin.x + rect.size.width - radius,
                        rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - radius);
    }
    
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
    
    if (cornerMask & UIImageRoundedCornerBottomRight) {
        CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius,
                        radius, 0.0f, -M_PI / 2, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, rect.origin.y);
    }
    
    CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
    
    if (cornerMask & UIImageRoundedCornerBottomLeft) {
        CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius,
                        -M_PI / 2, M_PI, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + radius);
    }
    
    CGContextClosePath(context);
}
// uiimage 圆角 弧角
- (UIImage *)roundedRectWith:(float)radius cornerMask:(UIImageRoundedCorner)cornerMask
{
    UIImageView *bkImageViewTmp = [[UIImageView alloc] initWithImage:self];
    
    int w = self.size.width;
    int h = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context,bkImageViewTmp.frame, radius, cornerMask);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage    *newImage = [UIImage imageWithCGImage:imageMasked];
    
    CGImageRelease(imageMasked);
    
    return newImage;
}

//切割 图片
#define APP_CACHE_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
-(NSDictionary*)SeparateImageByX:(int)x andY:(int)y cacheQuality:(float)quality
{
	
	//kill errors
	if (x<1) {
		NSLog(@"illegal x!");
		return nil;
	}else if (y<1) {
		NSLog(@"illegal y!");
		return nil;
	}
	if (![self isKindOfClass:[UIImage class]]) {
		NSLog(@"illegal image format!");
		return nil;
	}
	
	//attributes of element
	float _xstep=self.size.width*1.0/(y);
	float _ystep=self.size.height*1.0/(x);
	NSMutableDictionary*_mutableDictionary=[[NSMutableDictionary alloc]init];
	//NSArray*_array=[imageName componentsSeparatedByString:@"."];
	//NSString*prefixName=[_array objectAtIndex:0];
	NSString*prefixName=@"win";
	
	//snap in context and create element image view
	for (int i=0; i<x; i++)
	{
		for (int j=0; j<y; j++)
		{
			CGRect rect=CGRectMake(_xstep*j, _ystep*i, _xstep, _ystep);
            NSLog(@"%f,%f,%f,%f",_xstep*j, _ystep*i, _xstep, _ystep);
			CGImageRef imageRef=CGImageCreateWithImageInRect([self CGImage],rect);
			UIImage* elementImage=[UIImage imageWithCGImage:imageRef];
            CFRelease(imageRef);
			UIImageView*_imageView=[[UIImageView alloc] initWithImage:elementImage];
			_imageView.frame=rect;
			NSString*_imageString=[NSString stringWithFormat:@"%@_%d_%d.jpg",prefixName,i,j];
			[_mutableDictionary setObject:_imageView forKey:_imageString];
			CFRelease((__bridge CFTypeRef)(_imageView));
			
			if (quality<=0)
			{
				continue;
			}
			quality=(quality>1)?1:quality;
            
			NSString*_imagePath=[APP_CACHE_PATH stringByAppendingPathComponent:_imageString];
			NSData* _imageData=UIImageJPEGRepresentation(elementImage, quality);
			[_imageData writeToFile:_imagePath atomically:NO];
		}
	}
	//return dictionary including image views
	NSDictionary*_dictionary=_mutableDictionary;
	return _dictionary;
}

@end

#pragma mark -  NSMutableArray

@implementation NSMutableArray (Extens)
/**
 *  排序
 *
 *  @param where  需要排序的字段 如果不指定 直接对数组进行排序
 *  @param isAsc  升序
 *  @param isCopy 是否拷贝
 *
 *  @return 返回排序后的数组
 */
-(NSMutableArray *) sortMutableArrwhere:(NSString *)where isAsc:(Boolean)isAsc isCopy:(Boolean)isCopy
{
	
	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:where ascending:isAsc];
    
    

	[self sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]]; // assign the sort descriptions to the array.
	return self;
}

///键-值
-(NSMutableArray *) sortMutableArrByDic:(NSDictionary*)dic
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    for (NSString *key in [dic allKeys]) {
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:[[dic valueForKey:key] boolValue]];
        [arr addObject:sortDescriptor];
    }
    [self sortUsingDescriptors:arr]; // assign the sort descriptions to the array.
	return self;
}

@end



@implementation UITabBarController (Extens)

-(void)setTabBarHidden:(BOOL)bol{
    if(bol == YES)//隐藏
    {
        [self.view setFrame:CGRectMake(0, 0, 320, 530)];
        NSArray *views = [self.view subviews];
        for(id v in views){
            if([v isKindOfClass:[UITabBar class]]){
                [(UITabBar *)v setHidden:YES];
            }
        }
    }else {//显示
        [self.view  setFrame:CGRectMake(0, 0, 320, 480)];
        NSArray *views = [self.view subviews];
        for(id v in views){
            if([v isKindOfClass:[UITabBar class]]){
                [(UITabBar *)v setHidden:NO];
            }
        }
    }
    
}



@end


@implementation UIView (KalAdditions)
//得到此view 所在的viewController
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next =
         next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

///把UIView 转换成图片
-(UIImage *)getImageFromView{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end



