//
//  ZSURLRouteForward.h
//  ZSRoute
//
//  Created by Josh on 2021/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZSURLRouteForward : NSObject

/// 泛解析域名，*为通配符
@property (nonatomic, copy) NSString *host;

/// 泛解析path，*为通配符
@property (nonatomic, copy) NSString *path;

/// 转发目标类，必须是 ZSURLRoute 的子类
@property (nonatomic, assign) Class target;

@end

NS_ASSUME_NONNULL_END
