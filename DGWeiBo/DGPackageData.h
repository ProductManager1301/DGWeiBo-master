//
//  DGPackageData.h
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/27.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^failureError)(NSError *error );

typedef void(^requestData)(id responseObject);


@interface DGPackageData : NSObject

/*!
 * @function 获取微博
 *
 * @abstract
 *  刷新最新公共微博
 *
 * @discussion
 *  appkey : 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 
 *  token : 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 
 *  count :   单页返回的记录条数，默认为50。
 
 *  page  :   返回结果的页码，默认为1。
 
 *  baseApp : 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
+ (void)newestPublicWeiboWithCount:(NSString *)count page:(NSString *)page baseApp:(NSString *)baseApp responseObject:(requestData)blockObject failure:(failureError)failure;


/*!
 * @function 获取用户信息
 *
 * @abstract
 * 获取用户基本信息
 *
 * @discussion
 *  uid  : 需要查询的用户ID
 *
 */
+ (void)gainUserInfoWithUID:(NSString *)uid responseObject:(requestData)blockObject failure:(failureError)failure;


/*!
 * @function 获取微博
 *
 * @abstract
 *  获取用户所关注的微博
 *
 * @discussion
 *  appkey : 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 
 *  token : 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 
 *  count :   单页返回的记录条数，默认为50。
 
 *  page  :   返回结果的页码，默认为1。
 
 *  baseApp : 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */

+ (void)attentionWeiboWithCount:(NSString *)count page:(NSString *)page baseApp:(NSString *)baseApp responseObject:(requestData)blockObject failure:(failureError)failure;


/*!
 * @function 获取微博评论
 *
 * @abstract
 * 获取指定微博的所用评论
 *
 * @discussion
 *
 * ID : 指定微博的ID
 *
 * count : 单页返回的记录条数，默认为50。
 *
 * page  : 返回结果的页码，默认为1。
 *
 */
+ (void)weiboCommentWithID:(NSString *)ID  count:(NSString *)count page:(NSString *)page responseObject:(requestData)blockObject failure:(failureError)failure;


/*!
 * @function 获取指定人发布过的微博
 *
 * @abstract
 * 拿到用户发布的微博
 *
 * @discusstion
 *
 * ID   : 指定发布人的id
 * page : 返回结果的页码，默认为1
 */
+ (void)userSendedWeiboWithID:(NSString *)ID page:(NSString *)page responseObject:(requestData)blockObject failure:(failureError)failure;


/*====================发布一条微博========================
 *ID为ID
 *  appkey : 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 
 *  token : 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 
 *  count :   单页返回的记录条数，默认为50。
 
 *  page  :   返回结果的页码，默认为1。
 
 *  baseApp : 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
*/
+(void)publishWeibothID:(NSString *)ID status:(NSString *)status rip:(NSString *)rip responseObject:(requestData)blockObject failure:(failureError)failure;



/*====================发布一条评论========================
 *  appkey : 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 
 *  token : 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 
 *  count :   单页返回的记录条数，默认为50。
 
 *  page  :   返回结果的页码，默认为1。
 
 *  baseApp : 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
*/
+(void)senderCommentsWithID:(NSString *)ID comment:(NSString *)comment rip:(NSString *)rip responseObject:(requestData)blockObject failure:(failureError)failure;

@end
