//
//  BHI_Utility.h
//
//  Created by Joe Jia on 7/5/10.
//  Copyright 2010 BHI Technologies, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


#define IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? YES : NO

@interface BHI_Utility : NSObject

+(NSURL*)urlFromSetting;
+(NSString*)getMessageFromError:(NSError*)error;
+(NSNumber*)getMusicItemIdFromString:(NSString*)string;
+(NSString*)getStringFromMusicItemId:(NSNumber*)number;
+ (NSString*) stringWithUUID;
+(NSString *)screenType;
@end




@interface UIColor (BHI_Extensions)

-(float)getRed;
-(float)getGreen;
-(float)getBlue;
@end




@interface NSDate (BHI_Extensions)


+(NSCalendar*)getCalendar;

-(NSString*)stringFromFormat:(NSString*)dateFormat;
-(BOOL)isBetweenDateFrom:(NSDate*)dateFrom to:(NSDate*)dateTo;
+(NSDateFormatter*)getOutputFormatter;
// get the start date of a day
-(NSDate*)getStartDate;
// get the end date of a day
-(NSDate*)getEndDate;
-(NSDate*)getFirstDayInWeek;
-(NSDate*)getLastDayInWeek;
-(NSDate*)getFirstDayInMonth;
-(NSDate*)getLastDayInMonth;
-(NSDate*)getFirstDayInQuarter;
-(NSDate*)getLastDayInQuarter;
-(NSDate*)getFirstDayInYear;
-(NSDate*)getLastDayInYear;
-(NSDate*)getTimeInDay;
-(NSDate*)getDateNoSeconds;
-(float)getSecondsSinceStartDay;
-(NSDate*)getDateWithAddSeconds:(long)seconds;
-(NSString*)getDateFormateWithDateShow:(BOOL)dateShow  withTimeShow:(BOOL)timeShow;
#define Equal 0
#define	Asc 1
#define	Desc -1
-(int)dateComparewithDate:(NSDate *)dt2;
+(NSDate*)formatterDate:(NSString *)style withDate:(NSString*)dateStr;
//时间格式化 date时间 style样式 
//type == 1: 根据时区改变
//type == 2: 固定样式
- (NSString *)formatterDatestyle:(NSString *)style type:(NSInteger)type;
//计算两个日期相隔天数
+(NSInteger)getDateToDateDays:(NSDate *)date withSaveDate:(NSDate *)saveDate;
//字符串转日期
+ (NSDate * )stringToNSDate: (NSString * )dateStr withFormat:(NSString*)format;
@end
//-------------------------------------------------------------------------------------------------------

@interface NSString (BHI_Extensions)

-(float)getStringHightfont:(UIFont*)font;
-(float)getStringWidthfont:(UIFont*)font;

-(NSString*)stringWithInt:(int)intNumber;
-(NSString*)stringWithFloat2:(float)floadNumber2;
-(NSString*)stringwithDouble2:(double)doubleNumber2;

-(NSData*)utf8;


/**
 *  利用正则表达式验证
 *
 *  @return bool
 */
-(BOOL)isValidateEmail;
/**
 *  判断手机号码
 *
 *  @return 返回null表示是手机号码
 */
- (NSString *)valiMobile;
+ (CGFloat)heightOfText:(NSString *)text theWidth:(float)width theFont:(UIFont*)aFont;
@end

@interface NSString (base64)
/**
 *  Base64加密
 *
 *  @return base64字符的data数据
 */
-(NSData*)dh_base64Encode_StringToData;
/**
 *  Base64加密
 *
 *  @return base64字符串
 */
-(NSString*)dh_base64Encode_StringTobase64Code;

/**
 *  base64解码
 *
 *  @return 解码后的data数据
 */
-(NSData*)dh_base64Decode_base64CodeToData;

/**
 *  base64解码
 *
 *  @return 解码后的字符串
 */
-(NSString*)dh_base64Decode_base64codeToString;
@end
@interface NSData (base64)

/**
 *  Base64加密
 *
 *
 *  @return base64字符的data数据
 */
-(NSData*)dh_base64Encode_DataToData;

/**
 *  Base64加密
 *
 *
 *  @return base64字符串
 */
-(NSString*)dh_base64Encode_DataTobase64Code;




/**
 *  base64解码
 *
 *  @return 解码后的data数据
 */
-(NSData*)dh_base64Decode_base64DataToData;
/**
 *  base64解码
 *
 *  @return 解码后的字符串
 */
-(NSString*)dh_base64Decode_base64DataToString;

@end

//-------------------------------------------------------------------------------------------------------
@interface NSString (md5)
- (NSString *) md5;
@end

@interface NSData (md5)
- (NSString*)md5;
@end



//-------------------------------------------------------------------------------------------------------
typedef enum {
    UIImageRoundedCornerTopLeft = 1,
    UIImageRoundedCornerTopRight = 1 << 1,
    UIImageRoundedCornerBottomRight = 1 << 2,
    UIImageRoundedCornerBottomLeft = 1 << 3
} UIImageRoundedCorner;

@interface UIImage (Extens)
/**
 *  压缩图片质量
 *
 *  @param image   图片
 *  @param percent 压缩比  0-1
 *
 *  @return 图片
 */
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent;
- (UIImage *)transformToSize:(CGSize)newSize;
- (UIImage *)transformToScale:(float)scaleSize;
//图片 圆角
- (UIImage *)roundedRectWith:(float)radius cornerMask:(UIImageRoundedCorner)cornerMask;
//图片 切割
-(NSDictionary*)SeparateImageByX:(int)x andY:(int)y cacheQuality:(float)quality;
@end
//-------------------------------------------------------------------------------------------------------

@interface NSMutableArray (Extens)
/**
 *  排序
 *
 *  @param where  需要排序的字段 如果不指定 直接对数组进行排序
 *  @param isAsc  升序
 *  @param isCopy 是否拷贝
 *
 *  @return 返回排序后的数组
 */
-(NSMutableArray *) sortMutableArrwhere:(NSString *)where isAsc:(Boolean)isAsc isCopy:(Boolean)isCopy;
-(NSMutableArray *) sortMutableArrByDic:(NSDictionary*)dic;
@end


@interface UITabBarController (Extens)
-(void)setTabBarHidden:(BOOL)bol;
@end

@interface UIView (KalAdditions)
///得到此view 所在的viewController
- (UIViewController*)viewController;
///把UIView 转换成图片
-(UIImage *)getImageFromView;
@end
