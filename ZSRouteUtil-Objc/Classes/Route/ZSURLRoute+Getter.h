//
//  ZSURLRoute+Getter.h
//  ZSRoute
//
//  Created by Josh on 2021/2/23.
//

#import "ZSURLRoute+Input.h"
#import "ZSURLRoute+Output.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Encoded)

- (NSString *)zs_queryURLEncodedStringForURLRoute;

@end

@interface ZSURLRoute (Getter)

/// 当前的 navigation controller
+ (UINavigationController *)zs_navigationController;

/// 当前的 presented controller
+ (UIViewController *)zs_presentedController;

/// 根据类获取当前 tabbar controller 的 subcontroller
/// @param controllerClass 类
+ (UIViewController *)zs_targetControllerFromControllerClass:(Class)controllerClass;

/// URL路由解析，返回可用的target controller
/// @param route 路由
+ (ZSURLRouteResult *)zs_routeResolution:(NSString *)route;

/// 获取路由的参数
/// @param route 路由
+ (NSDictionary <NSString *, NSString *> *)zs_parmasFromRoute:(NSString *)route;

/// 获取 forward target
/// @param result 路由解析结果
+ (Class)zs_forwardTargetFromResult:(ZSURLRouteResult *)result;

/// 获取 target controller
/// @param route 路由
/// @param isCheckTabbar 是否检索是 tabbar controller
+ (UIViewController *)zs_targetControllerFromRoute:(NSString *)route isCheckTabbar:(BOOL)isCheckTabbar;

/// 获取 target view
/// @param route 路由
+ (UIView *)zs_targetViewFromRoute:(NSString *)route;

@end

NS_ASSUME_NONNULL_END
