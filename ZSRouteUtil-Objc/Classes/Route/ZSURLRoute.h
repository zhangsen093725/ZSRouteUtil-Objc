//
//  ZSURLRoute.h
//  ZSRoute
//
//  Created by Josh on 2021/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZSURLRoute : NSObject

/// 去除路由中不必要的空格
/// @param link 路由链接
+ (NSString *)zs_removeWhitespacesAndNewlinesLinkFromLink:(NSString *)link;

@end

NS_ASSUME_NONNULL_END
