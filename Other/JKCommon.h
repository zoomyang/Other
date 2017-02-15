//
//  JKCommon.h
//  CommlibIOSDemo
//
//  Created by 杨剑 on 14-8-5.
//  Copyright (c) 2014年 zdksii. All rights reserved.
//

#import "Exp.h"

#import "AppDelegate.h"

///////////////////////////
#import "BHI_Utility.h"

///////////////////////////







#ifndef CommlibIOSDemo_JKCommon_h
#define CommlibIOSDemo_JKCommon_h

#define os_success 1  //成功
#define os_false 0    //失败






//#define RED5_HOST @"192.168.4.111"
//#define RED5_PORT 1935

#define os_success_status 200  //网络请求成功状态码

#pragma mark -
#define App_Delegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define bself(a) jkbself(a)


#define KeyWindow [UIApplication sharedApplication].keyWindow
#define windowSize [[UIScreen mainScreen] bounds].size
#define jkviewSize (self.view.bounds.size)



#define USERNAME @"userName"
#define PASSWORD @"password"







#define CURRENT_LANGUAGE(key) [[LanguageManager shageLanguageManager] languageByKey:key]

#pragma mark -
#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define PRODUCT_ADJUNCT_PATH ([DOCUMENT_PATH stringByAppendingPathComponent:@"PRODUCT_ADJUNCT"])

#define upload_path ([DOCUMENT_PATH stringByAppendingString:@"/upload"])

#pragma mark -
#define ios_version [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7 (ios_version >= 7?YES:NO)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define MFISPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#pragma mark - dic 快速取值
//dic 快速取值
#define OS_VALUE(dic,Name) ([dic valueForKey:Name]==[NSNull null]?@"":[dic valueForKey:Name])
#define OS_VALUE_nil(dic,Name) ([dic valueForKey:Name]==[NSNull null]?nil:[dic valueForKey:Name])
#define OS_LONG_VALUE(dic,Name) ([dic valueForKey:Name]==[NSNull null]?0:[[dic valueForKey:Name] longValue])
#define OS_INT_VALUE(dic,Name) ([dic valueForKey:Name]==[NSNull null]?0:[[dic valueForKey:Name] intValue])
#define OS_DOUBLE_VALUE(dic,Name) ([dic valueForKey:Name]==[NSNull null]?0:[[dic valueForKey:Name] doubleValue])
#define OS_FLOAT_VALUE(dic,Name) ([dic valueForKey:Name]==[NSNull null]?0:[[dic valueForKey:Name] floatValue])

#define OS_STRING_VALUE(dic,Name) (checkClassTypeAndtoString(dic,Name))

#define DEVICE_SCREEN [BHI_Utility screenType]


#pragma mark - 数值转换成String
//数值转换成String
#define OS_STRING_d(a) [NSString stringWithFormat:@"%d",a]
#define OS_STRING_f(a) [NSString stringWithFormat:@"%f",a]
#define OS_STRING_0f(a) [NSString stringWithFormat:@"%.0f",a]
#define OS_STRING_1f(a) [NSString stringWithFormat:@"%.1f",a]
#define OS_STRING_2f(a) [NSString stringWithFormat:@"%.2f",a]
#define OS_STRING_lu(a) [NSString stringWithFormat:@"%lu",a]

//------------------------------------------

#define CODE_MESSAGE @"message"

#define CODE_STATUS @"code"

#define CODE_TOKEN @"token"

///状态码 成功 失败
#define CODE_SUCCESS @"111"
#define CODE_FALSE @"000"
#define CODE_TOKEN_OVERDUE @"999"
#define CODE_NONE @"666"
#define CODE_CANCEL @"CANCLE_CODE"

typedef enum{
    CODE_REGUEST=1,
    CODE_FORGOT=2
}CODE_TYPE;


#define HOST @"192.168.221.154"
#define PORT 5222
#define MFDomain @"@yang"

#define SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER_ARC(__CLASSNAME__)	\
\
+ (instancetype) sharedInstance;

/**
 *  快速单例
 *
 *  @param __CLASSNAME__ 类名
 *
 *  @return 单例对象
 */
#define SYNTHESIZE_SINGLETON_FOR_CLASS_ARC(__CLASSNAME__)	\
\
static /*volatile liufeng use this will cause a warning*/ __CLASSNAME__* _##__CLASSNAME__##_sharedInstance = nil;	\
\
+(instancetype)sharedInstance\
{\
if (_##__CLASSNAME__##_sharedInstance==nil) {\
_##__CLASSNAME__##_sharedInstance=[[self alloc] init];\
}\
return _##__CLASSNAME__##_sharedInstance;\
}




#define UserDefault_UserId        @"UserDefault_UserId"
#define UserDefault_UserName        @"UserDefault_Username"
#define UserDefault_UserPwd         @"UserDefault_UserPwd"
#define UserDefault_XmppToken         @"UserDefault_XmppToken"
#define UserDefault_LoginAuthType   @"UserDefault_LoginAuthType"
#define UserDefault_IsSandbox       @"UserDefault_IsSandbox"

#pragma mark - 枚举
typedef enum {
    /**
     *  不是注册用户
     */
    MyAddressFriendType_not_a_registered_user = 0,
    /**
     *  是注册用户但是不是好友
     */
    MyAddressFriendType_is_a_registered_user_but_not_a_friend = 1,
    /**
     *  是好友
     */
    MyAddressFriendType_is_a_good_friend
}MyAddressFriendType;

/**
 * 性别
 */
typedef NS_ENUM(NSInteger,ECSexType){
    
    /** 男 */
    ECSexType_Male=1,
    
    /** 女 */
    ECSexType_Female
};

/**
 * 其他活动分类  我的活动，我的关注的活动，我的报名的活动
 */
typedef enum {
    /**
     *  我的活动
     */
    other_type_myActivity=0,

    /**
     *  我的关注
     */
    other_type_myConcern=1,
    /**
     *  我的报名
     */
    other_type_myRegistration=2,
    /**
     *  所有数据
     */
    other_type_All=3
    
}other_type;

#pragma mark - 通知
#define notification_update_friendsInfo @"notification_update_friendsInfo"
/**
 *  二维好友 通知
 *
 *  @param homePic notification_load_TwofriendsInfo
 *
 *  @return notification_load_TwofriendsInfo
 */
#define notification_load_TwofriendsInfo @"notification_load_TwofriendsInfo"

/**
 *  关注的好友 通知
 *
 *  @param homePic notification_load_FollowfriendsInfo
 *
 *  @return notification_load_FollowfriendsInfo
 */
#define notification_load_FollowfriendsInfo @"notification_load_FollowfriendsInfo" 

/**
 *  取消关注的好友 通知
 *
 *  @param homePic notification_load_unFollowfriendsInfo
 *
 *  @return notification_load_unFollowfriendsInfo
 */
#define notification_load_unFollowfriendsInfo @"notification_load_unFollowfriendsInfo" 

/**
 *  所有活动
 *
 *  @param homePic notification_reloadActivitView_ALL
 *
 *  @return notification_reloadActivitView_ALL
 */
#define notification_reloadActivitView_ALL @"notification_reloadActivitView_ALL"

/**
 *  我的活动
 *
 *  @param homePic notification_reloadActivitView_MyActivity
 *
 *  @return notification_reloadActivitView_MyActivity
 */
#define notification_reloadActivitView_MyActivity @"notification_reloadActivitView_MyActivity" 

/**
 *  我的关注
 *
 *  @param homePic notification_reloadActivitView_myConcern
 *
 *  @return notification_reloadActivitView_myConcern
 */
#define notification_reloadActivitView_myConcern @"notification_reloadActivitView_myConcern"

/**
 *  我的报名
 *
 *  @param homePic notification_reloadActivitView_myRegistration
 *
 *  @return notification_reloadActivitView_myRegistration
 */
#define notification_reloadActivitView_myRegistration @"notification_reloadActivitView_myRegistration"

/**
 *  取消活动
 *
 *  @param homePic notification_cancelReloadActivitView
 *
 *  @return notification_cancelReloadActivitView
 */
#define notification_cancelReloadActivitView @"notification_cancelReloadActivitView"

/**
 *  更新通讯录 注册好友
 *
 *  @param homePic notification_update_localaddressFile
 *
 *  @return notification_update_localaddressFile
 */
#define notification_update_localaddressFile @"notification_update_localaddressFile"

/**
 *  活动详情
 *
 *  @param homePic notification_eventDetail_join
 *
 *  @return notification_eventDetail_join
 */
#define notification_eventDetail_join @"notification_eventDetail_join"

/**
 *  关注活动
 *
 *  @param homePic notification_eventDetail_follow
 *
 *  @return notification_eventDetail_follow
 */
#define notification_eventDetail_follow @"notification_eventDetail_follow"



#pragma mark - PATH
#define MFUserInfopath [DOCUMENT_PATH stringByAppendingPathComponent:@"userinfo"]

//#define HOST @"192.168.1.102"
//#define HOST @"192.168.1.101"
//#define PORT 1024


//#define HTTP_PATH @"192.168.4.110:8080/syncpad/"
//#define HTTP_PATH @"192.168.3.103:8080/syncpad/"
//#define HTTP_PATH @"192.168.222.152:8080/syncpad/"
#define HTTP_PATH @"120.27.37.201/Instansmile"

#define HTTP_IMAGE_PATH @"http://instansmile.img-cn-shanghai.aliyuncs.com/"
#define IMAGE_PATH @"instansmile.img-cn-shanghai.aliyuncs.com"

/**
 *  默认图片大小
 *
 *  @param homePic 图片相对路径
 *
 *  @return 完整路劲
 */
#define HTTP_IMAGE_PATH_DEFAULT(homePic) [NSString stringWithFormat:@"%@/%@",HTTP_IMAGE_PATH,homePic]

/**
 *  裁剪过后的图片大小
 *
 *  @param homePic 图片相对路径
 *
 *  @return 完整路劲
 */
#define HTTP_IMAGE_PATH_FALL(homePic) [NSString stringWithFormat:@"%@/%@@!%@",HTTP_IMAGE_PATH,homePic,DEVICE_SCREEN]




#pragma mark - function

/**
 *  获取验证码
 *
 *  @return @"verification/getCode/%@/%d?format=json"
 */
#define function_getCode_2 @"verification/getCode/%@/%d?format=json"

/**
 *  登陆
 *
 *  @return @"user/login.json?format=json"
 */
#define function_login @"user/login.json?format=json"

/**
 *  注册
 *
 *  @return @"user/register?format=json"
 */
#define function_register @"user/register?format=json"


/**
 *  用于实现用户密码重置
 *
 *  @return @"user/getback?format=json"
 */
#define function_getback @"user/getback?format=json"

/**
 *  用于用户更换头像
 *
 *  @return @"user/changeAvatar?format=json"
 */
#define function_changeAvatar @"user/changeAvatar?format=json"


/**
 *  查询活动列表
 *
 *  @return @"event/list?format=json"
 */
#define function_Activity @"event/list?format=json"

/**
 *  根据ID获取活动详情
 *
 *  @return @"event/getdetail?format=json"
 */
#define function_getdetail @"event/getdetail?format=json"

/**
 *  获取一维好友
 *
 *  @return @"friend/getOneDimensional?format=json"
 */
#define function_friend_getOneDimensional @"friend/getOneDimensional?format=json"
/**
 *  获取二维好友
 *
 *  @return @"friend/getTwoDimensional?format=json"
 */
#define function_friend_getTwoDimensional @"friend/getTwoDimensional?format=json"


/**
 *  根据活动的编码查询评论列表
 *
 *  @return comment/list?format=json
 */
#define function_comment_list @"comment/list?format=json"

/**
 *  添加评论
 *
 *  @return comment/add?format=json
 */
#define function_comment_add @"comment/add?format=json"

/**
 *  添加活动
 *
 *  @return event/add?format=json
 */
#define function_event_add @"event/add?format=json"

/**
 *  根据用户ID查询用户信息，（含成就，兴趣标签，身份标签等信息）
 *
 *  @return user/getUser?format=json
 */
#define function_user_getUser @"user/getUser?format=json"


/**
 *  添加关注 关注用户 关注好友
 *
 *  @return friend/follow?format=json
 */
#define function_user_friend_follow @"friend/follow?format=json"

/**
 *  取消关注
 *
 *  @return friend/unFollow?format=json
 */
#define function_unFollow @"friend/unFollow?format=json"

/**
 *  获取标签 根据标签类型（兴趣/身份）获取个人标签信息             type 标签类型 1兴趣 2身份
 *
 *  @return common/list?format=json
 */
#define function_common_list @"common/list?format=json"

/**
 *  获取通讯录好友的注册信息
 *
 *  @return user/getRegisteredUsers?format=json
 */
#define function_user_getRegisteredUsers @"user/getRegisteredUsers?format=json"

/**
 *  上传本地通讯录
 *
 *  @return common/uploadAddressBook?format=json
 */
#define function_common_uploadAddressBook @"common/uploadAddressBook?format=json"

/**
 *  用于用户发送添加好友请求
 *
 *  @return friend/add?format=json
 */
#define function_friend_add @"friend/add?format=json"


/**
 *  在登陆成功后进行推送绑定
 *
 *  @return common/pushBind?format=json
 */
#define function_common_pushBind @"common/pushBind?format=json"

/**
 *  用于获取国籍
 *
 *  @return region/nations?format=json
 */
#define function_region_nations @"region/nations?format=json"

/**
 *  根据国籍编码获取省份
 *
 *  @return region/provinces?format=json
 */
#define  function_region_provinces @"region/provinces?format=json"

/**
 *  根据省份编码获取所属城市列表
 *
 *  @return region/cities?format=json
 */
#define function_region_cities @"region/cities?format=json"

/**
 *  根据城市编码获取所属区县列表
 *
 *  @return region/districts?format=json
 */
#define function_region_districts @"region/districts?format=json"

/**
 *  根据标签类型（兴趣/身份）获取个人标签信息
 *
 *  @return common/list?format=json
 */
#define function_common_list @"common/list?format=json"

/**
 *  关注活动
 *
 *  @return event/follow?format=json
 */
#define function_event_follow @"event/follow?format=json"

/**
 *  取消关注活动
 *
 *  @return event/unfollow?format=json
 */
#define function_event_unfollow @"event/unfollow?format=json"

/**
 *  加入活动
 *
 *  @return event/join?format=json
 */
#define function_event_join @"event/join?format=json"

/**
 *  取消加入活动
 *
 *  @return event/leave?format=json
 */
#define function_event_leave @"event/leave?format=json"

/**
 *  获取新的朋友列表
 *
 *  @return friend/getNewFriends?format=json
 */
#define function_friend_getFocusList @"friend/getNewFriends?format=json"

/**
 *  同意好友请求
 *
 *  @return friend/accpect?format=json
 */
#define function_friend_accpect @"friend/accpect?format=json"

/**
 *  取消自己发布的活动
 *
 *  @return event/cancel?format=json
 */
#define function_event_cancel @"event/cancel?format=json"

/**
 *  获取关注好友的列表
 *
 *  @return friend/getFollowList?format=json
 */
#define function_friend_getFollowList @"friend/getFollowList?format=json"

/**
 *  设置一维好友的权限
 *
 *  @return friend/settings?format=json
 */
#define function_friend_settings @"friend/settings?format=json"

/**
 *  修改个人信息
 *
 *  @return user/updateUserInfo?format=json
 */
#define function_user_updateUserInfo @"user/updateUserInfo?format=json"

/**
 *  我的二维码
 *
 *  @return 0640efd4d47a11e5bb8000163e005ff8/QR_CODE/QRcode.png
 */
#define function_qr @"OpenFlower/0640efd4d47a11e5bb8000163e005ff8/QR_CODE/QRcode.png"

#endif
