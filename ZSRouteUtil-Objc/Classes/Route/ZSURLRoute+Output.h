//
//  ZSURLRoute+Output.h
//  ZSRoute
//
//  Created by Josh on 2021/2/23.
//

#import "ZSURLRoute.h"
#import "ZSURLRouteResult.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZSURLRouteOutput <NSObject>

/// 路由解析完成的回调
/// @param result 路由解析结果
+ (id<ZSURLRouteOutput>)zs_didFinishRouteResult:(ZSURLRouteResult *)result;

@end


@interface ZSURLRoute (Output)

/// 是否开启日志信息
+ (BOOL)zs_logEnable;

/// 根据路由规则，找到 targetClass
/// @param result 路由解析结果
+ (Class<ZSURLRouteOutput>)zs_routeTargetFromResult:(ZSURLRouteResult *)result;

/// 路由解析跳转失败
/// @param route 失败的路由地址
/// @param error 错误信息
+ (void)zs_route:(NSString *)route didFail:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
