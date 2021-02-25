//
//  ZSURLRouteResult.h
//  ZSRoute
//
//  Created by Josh on 2021/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZSURLRouteResult : NSObject

/// 解析后的 scheme
@property (nonatomic, copy) NSString *scheme;

/// 解析后的 host
@property (nonatomic, copy) NSString *host;

/// 解析后的 path
@property (nonatomic, copy) NSString *path;

/// 解析后的 params
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> *params;

/// 解析后被忽略的 query
@property (nonatomic, copy) NSString *ignoreQuery;

/// 解析后的 route
@property (nonatomic, copy) NSString *route;

/// 原始的 scheme
@property (nonatomic, copy) NSString *originScheme;

/// 原始的 host
@property (nonatomic, copy) NSString *originHost;

/// 原始的 path
@property (nonatomic, copy) NSString *originPath;

/// 原始的 query
@property (nonatomic, copy) NSString *query;

/// 原始的 originRoute
@property (nonatomic, copy) NSString *originRoute;

@end

NS_ASSUME_NONNULL_END
