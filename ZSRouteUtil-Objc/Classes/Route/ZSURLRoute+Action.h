//
//  ZSURLRoute+Action.h
//  ZSRoute
//
//  Created by Josh on 2021/2/23.
//

#import "ZSURLRoute+Getter.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZSURLRoute (Action)

/// 切换选中的 tabbar controller
/// @param controller 需要切换的控制器
+ (BOOL)zs_setTabbarSelectedController:(UIViewController *)controller;



/// push 到指定路由，isCheckTabbar 为YES，animated 为YES
/// @param route 路由
+ (UIViewController *)zs_pushFromRoute:(NSString *)route;

/// push 到指定路由，isCheckTabbar 为YES
/// @param route 路由
/// @param animated 是否开启动画
+ (UIViewController *)zs_pushFromRoute:(NSString *)route
                              animated:(BOOL)animated;

/// push 到指定路由
/// @param route 路由
/// @param isCheckTabbar 是否开启 tabbar 验证
/// @param animated 是否开启动画
+ (UIViewController *)zs_pushFromRoute:(NSString *)route
                         isCheckTabbar:(BOOL)isCheckTabbar
                              animated:(BOOL)animated;



/// pop 到指定路由，isCheckTabbar 为YES，animated 为YES
/// @param route 路由
+ (UIViewController *)zs_popFromRoute:(NSString *)route;

/// pop 到指定路由，isCheckTabbar 为YES
/// @param route 路由
/// @param animated 是否开启动画
+ (UIViewController *)zs_popFromRoute:(NSString *)route
                             animated:(BOOL)animated;

/// pop 到指定路由
/// @param route 路由
/// @param isCheckTabbar 是否开启 tabbar 验证
/// @param animated 是否开启动画
+ (UIViewController *)zs_popFromRoute:(NSString *)route
                        isCheckTabbar:(BOOL)isCheckTabbar
                             animated:(BOOL)animated;


/// present 到指定路由，isCheckTabbar 为YES，animated 为YES
/// @param route 路由
/// @param completion 动画完成
+ (UIViewController *)zs_presentFromRoute:(NSString *)route
                               completion:(void(^)(void))completion;

/// present 到指定路由，isCheckTabbar 为YES
/// @param route 路由
/// @param animated 是否开启动画
/// @param completion 动画完成
+ (UIViewController *)zs_presentFromRoute:(NSString *)route
                                 animated:(BOOL)animated
                               completion:(void(^)(void))completion;

/// present 到指定路由
/// @param route 路由
/// @param isCheckTabbar 是否开启 tabbar 验证
/// @param animated 是否开启动画
/// @param completion 动画完成
+ (UIViewController *)zs_presentFromRoute:(NSString *)route
                            isCheckTabbar:(BOOL)isCheckTabbar
                                 animated:(BOOL)animated
                               completion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
