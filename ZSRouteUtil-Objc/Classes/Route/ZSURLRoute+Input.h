//
//  ZSURLRoute+Input.h
//  ZSRoute
//
//  Created by Josh on 2021/2/23.
//

#import "ZSURLRoute.h"
#import "ZSURLRouteForward.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZSURLRoute (Input)

/// scheme 的路由映射
+ (NSDictionary<NSString *, NSString *> *)zs_schemeMap;

/// host 的路由映射
+ (NSDictionary<NSString *, NSString *> *)zs_hostMap;

/// path 的路由映射
+ (NSDictionary<NSString *, NSString *> *)zs_pathMap;

/// 需要替换 query 的键值
+ (NSDictionary<NSString *, NSString *> *)zs_replaceQuery;

/// 需要忽略解析 query 的键
+ (NSArray<NSString *> *)zs_ignoreQueryKey;

/// 路由转发策略表
+ (NSArray<ZSURLRouteForward *> *)zs_forwardList;

/// 是否开启路由转发策略
+ (BOOL)zs_forwardEnable;

/// 是否忽略 scheme、host、path 的大小写
+ (BOOL)zs_ignoreCaseEnable;

/// 是否过滤路由中的空格
+ (BOOL)zs_filterWhitespacesEnable;

/// 参数替换的映射
/// @param params 参数
+ (NSDictionary<NSString *, NSString *> *)zs_replaceFromParams:(NSDictionary<NSString *, NSString *> *)params;

@end

NS_ASSUME_NONNULL_END
