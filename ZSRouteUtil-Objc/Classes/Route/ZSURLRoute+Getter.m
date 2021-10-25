//
//  ZSURLRoute+Getter.m
//  ZSRoute
//
//  Created by Josh on 2021/2/23.
//

#import "ZSURLRoute+Getter.h"

@implementation NSDictionary (Encoded)

- (NSString *)zs_queryURLEncodedStringForURLRoute {
    
    NSMutableString *query = [NSMutableString string];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull val, BOOL * _Nonnull stop) {
            
        if ([val isKindOfClass:[NSString class]])
        {
            NSCharacterSet *characteSet = [NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"].invertedSet;
            [query appendFormat:@"%@=%@&", key, [val stringByAddingPercentEncodingWithAllowedCharacters:characteSet]];
            return;
        }
        
        [query appendFormat:@"%@=%@&", key, val];
    }];
    
    if (query.length > 0)
    {
        [query deleteCharactersInRange:NSMakeRange(query.length - 1, 1)];
    }
    
    return [query copy];
}

@end



@implementation ZSURLRoute (Getter)

+ (UINavigationController *)zs_navigationController {
    
    UIViewController *controller = [self zs_presentedController];
    
    if ([controller isKindOfClass:[UINavigationController class]])
    {
        return (UINavigationController *)controller;
    }
    
    return nil;
}

+ (UIViewController *)zs_presentedController {
    
    UIViewController *rootViewController = UIApplication.sharedApplication.keyWindow.rootViewController;
    
    if (rootViewController == nil) { return nil; }
    
    UIViewController *controller = rootViewController;
    
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        controller = ((UITabBarController *)rootViewController).selectedViewController;
    }
    
    while (controller.presentedViewController != nil)
    {
        controller = controller.presentedViewController;
    }
    return controller;
}

+ (UIViewController *)zs_targetControllerFromControllerClass:(Class)controllerClass {
    
    UIViewController *rootViewController = UIApplication.sharedApplication.keyWindow.rootViewController;
    
    UITabBarController *tabbarController;
    
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        tabbarController = (UITabBarController *)rootViewController;
    }
    
    for (UIViewController *controller in tabbarController.viewControllers)
    {
        if ([controller isKindOfClass:[UINavigationController class]])
        {
            UIViewController *subController = ((UINavigationController *)controller).viewControllers.firstObject;
            
            if ([subController isMemberOfClass:controllerClass])
            {
                return subController;
            }
        }
        
        if ([controller isMemberOfClass:controllerClass])
        {
            return controller;
        }
    }
    return nil;
}

+ (ZSURLRouteResult *)zs_routeResolution:(NSString *)route {
    
    NSString *_route_ = [self zs_filterWhitespacesEnable] ? [self zs_removeWhitespacesAndNewlinesLinkFromLink:route] : route;
    
    if (_route_ == nil)
    {
        NSError *error = [NSError errorWithDomain:@"route is empty" code:400 userInfo:@{NSLocalizedDescriptionKey : @"路由地址为空"}];
        [self zs_route:@"" didFail:error];
        return nil;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setDictionary:[self zs_parmasFromRoute:_route_]];
    
    NSRange queryRange = [_route_ rangeOfString:@"?" options:NSCaseInsensitiveSearch range:NSMakeRange(0, _route_.length)];
    
    NSString *removeQueryLink = _route_;
    
    if (queryRange.location < _route_.length)
    {
        removeQueryLink = [_route_ substringToIndex:queryRange.location];
    }
    
    NSDictionary *tempParams = [params copy];
    [params removeAllObjects];
    [params setDictionary:[self zs_replaceFromParams:tempParams]];
    
    NSMutableDictionary *ignoreParams = [NSMutableDictionary dictionary];
    
    for (NSString *key in [self zs_ignoreQueryKey])
    {
        [ignoreParams setValue:params[key] forKey:key];
        [params removeObjectForKey:key];
    }
    
    NSString *ignoreQuery = [[ignoreParams copy] zs_queryURLEncodedStringForURLRoute];
    
    NSString *removeQueryRoute = [removeQueryLink stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    if (removeQueryRoute == nil)
    {
        removeQueryRoute = removeQueryLink;
    }
    
    NSURL *removeQueryURL = [NSURL URLWithString:removeQueryRoute];
    
    if (removeQueryURL == nil)
    {
        NSError *error = [NSError errorWithDomain:@"Not Found" code:404 userInfo:@{NSLocalizedDescriptionKey : @"路由地址不正确"}];
        [self zs_route:route didFail:error];
        return nil;
    }
    
    ZSURLRouteResult *result = [ZSURLRouteResult new];
    
    result.originRoute = _route_;
    result.route = removeQueryRoute;
    
    if (ignoreQuery.length > 0)
    {
        result.route = [NSString stringWithFormat:@"%@?%@", result.route, ignoreQuery];
    }
    
    result.ignoreQuery = ignoreQuery;
    result.params = params;
    
    result.originScheme = removeQueryURL.scheme;
    NSString *scheme = [self zs_ignoreCaseEnable] ? [result.originScheme lowercaseString] : result.originScheme;
    result.scheme = [self zs_schemeMap][scheme];
    if (result.scheme == nil)
    {
        result.scheme = result.originScheme;
    }
    
    [[self zs_schemeMap] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull value, BOOL * _Nonnull stop) {
       
        NSString *schemeRule = [key stringByReplacingOccurrencesOfString:@"*" withString:@".*"];
        NSPredicate *predcate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", schemeRule];
        
        if ([predcate evaluateWithObject:scheme])
        {
            result.scheme = value;
        }
    }];
    
    result.originHost = removeQueryURL.host;
    NSString *host = [self zs_ignoreCaseEnable] ? result.originHost.lowercaseString : result.originHost;
    result.host = [self zs_hostMap][host];
    if (result.host == nil)
    {
        result.host = result.originHost;
    }
    
    [[self zs_hostMap] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull value, BOOL * _Nonnull stop) {
       
        NSString *hostRule = [key stringByReplacingOccurrencesOfString:@"." withString:@"[.]"];
        hostRule = [key stringByReplacingOccurrencesOfString:@"*" withString:@".*"];
        
        NSPredicate *predcate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", hostRule];
        
        if ([predcate evaluateWithObject:host])
        {
            result.host = value;
        }
    }];
    
    result.originPath = removeQueryURL.path;
    NSString *path = [self zs_ignoreCaseEnable] ? result.originPath.lowercaseString : result.originPath;
    result.path = [self zs_pathMap][path];
    if (result.path == nil)
    {
        result.path = result.originPath;
    }
    
    [[self zs_pathMap] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull value, BOOL * _Nonnull stop) {
       
        NSString *pathRule = [key stringByReplacingOccurrencesOfString:@"*" withString:@".*"];
        NSPredicate *predcate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", pathRule];
        
        if ([predcate evaluateWithObject:path])
        {
            result.path = value;
        }
    }];
    
    return result;
}

+ (NSDictionary<NSString *,NSString *> *)zs_parmasFromRoute:(NSString *)route {
    
    NSString *_route_ = [self zs_filterWhitespacesEnable] ? [self zs_removeWhitespacesAndNewlinesLinkFromLink:route] : route;
    
    if (_route_ == nil) { return @{}; }
    
    NSRange queryRange = [_route_ rangeOfString:@"?" options:NSCaseInsensitiveSearch range:NSMakeRange(0, _route_.length)];
    
    if (queryRange.location >= _route_.length) { return @{}; }
    
    NSString *query = [_route_ substringFromIndex:queryRange.location + 1];
    NSArray *querys = [query componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    for (NSString *element in querys)
    {
        NSRange paramsRange = [element rangeOfString:@"=" options:NSCaseInsensitiveSearch range:NSMakeRange(0, element.length)];
        
        if (paramsRange.location >= element.length) { continue; }
        
        NSString *key = [element substringToIndex:paramsRange.location];
        NSString *val = [element substringFromIndex:paramsRange.location + 1];
        
        [params setValue:val forKey:key];
    }
    
    return [params copy];
}

+ (Class)zs_forwardTargetFromResult:(ZSURLRouteResult *)result {
    
    if ([self zs_forwardEnable] == NO) { return nil; }
    
    ZSURLRouteForward *forward = [ZSURLRouteForward new];
    
    for (ZSURLRouteForward *obj in [self zs_forwardList])
    {
        NSString *host = [self zs_ignoreCaseEnable] ? obj.host.lowercaseString : obj.host;
        NSString *hostRule = [host stringByReplacingOccurrencesOfString:@"." withString:@"[.]"];
        hostRule = [host stringByReplacingOccurrencesOfString:@"*" withString:@".*"];
        
        NSPredicate *predcate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", hostRule];
        
        BOOL isForward = [predcate evaluateWithObject:([self zs_ignoreCaseEnable] ? result.host.lowercaseString : result.host)];
        
        if (obj.path.length > 0 && isForward)
        {
            NSString *path = [self zs_ignoreCaseEnable] ? obj.path.lowercaseString : obj.path;
            NSString *pathRule = [path stringByReplacingOccurrencesOfString:@"*" withString:@".*"];
            
            predcate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", pathRule];
             
            isForward = [predcate evaluateWithObject:([self zs_ignoreCaseEnable] ? result.path.lowercaseString : result.path)];
        }
        
        if (isForward)
        {
            forward = obj;
            break;
        }
    }
    
    return forward.target;
}

+ (UIViewController *)zs_targetControllerFromRoute:(NSString *)route isCheckTabbar:(BOOL)isCheckTabbar {

    ZSURLRouteResult *result = [self zs_routeResolution:route];

    if (result == nil)
    {
        NSError *error = [NSError errorWithDomain:@"Bad Gateway" code:502 userInfo:@{NSLocalizedDescriptionKey : @"路由地址不正确"}];
        [self zs_route:route didFail:error];
        return nil;
    }
    
    Class forwardTarget = [self zs_forwardTargetFromResult:result];
    
    if (forwardTarget)
    {
        return [forwardTarget zs_targetControllerFromRoute:route isCheckTabbar:isCheckTabbar];
    }
    
    Class<ZSURLRouteOutput> targetClass = [self zs_routeTargetFromResult:result];
    
    if (targetClass == nil)
    {
        NSError *error = [NSError errorWithDomain:@"Not Found" code:404 userInfo:@{NSLocalizedDescriptionKey : @"路由地址不正确"}];
        [self zs_route:route didFail:error];
        return nil;
    }
    
    Class superclass = targetClass;
    BOOL isKindOfClass = NO;
    
    while (superclass.superclass != nil)
    {
        if (superclass == [UIViewController class])
        {
            isKindOfClass = YES;
            break;
        }
        superclass = superclass.superclass;
    }
    
    if (isKindOfClass == NO)
    {
        NSError *error = [NSError errorWithDomain:@"target 不是 UIViewController.class 及其子类" code:500 userInfo:@{NSLocalizedDescriptionKey : @"请在 zs_routeTarget 中返回 UIViewController.class 及其子类"}];
        [self zs_route:route didFail:error];
        return nil;
    }
    
    UIViewController *targetController;
    
    if (isCheckTabbar)
    {
        targetController = [self zs_targetControllerFromControllerClass:targetClass];
    }
    
    if (targetController == nil)
    {
        id<ZSURLRouteOutput> _targetController = [targetClass zs_didFinishRouteResult:result];
        
        if ([_targetController isKindOfClass:[UIViewController class]] == NO)
        {
            NSError *error = [NSError errorWithDomain:@"ty_didFinishRouteResult 返回对象类型错误" code:502 userInfo:@{NSLocalizedDescriptionKey : @"请在 zs_didFinishRouteResult 中返回 UIViewController 及其子类"}];
            [self zs_route:route didFail:error];
            return nil;
        }
        
        targetController = (UIViewController *)_targetController;
    }
    
    return targetController;
}

+ (UIView *)zs_targetViewFromRoute:(NSString *)route {
    
    ZSURLRouteResult *result = [self zs_routeResolution:route];

    if (result == nil)
    {
        NSError *error = [NSError errorWithDomain:@"Bad Gateway" code:502 userInfo:@{NSLocalizedDescriptionKey : @"路由地址不正确"}];
        [self zs_route:route didFail:error];
        return nil;
    }
    
    Class forwardTarget = [self zs_forwardTargetFromResult:result];
    
    if (forwardTarget)
    {
        return [forwardTarget zs_targetViewFromRoute:route];
    }
    
    Class<ZSURLRouteOutput> targetClass = [self zs_routeTargetFromResult:result];
    
    if (targetClass == nil)
    {
        NSError *error = [NSError errorWithDomain:@"Not Found" code:404 userInfo:@{NSLocalizedDescriptionKey : @"路由地址不正确"}];
        [self zs_route:route didFail:error];
        return nil;
    }
    
    Class superclass = targetClass;
    BOOL isKindOfClass = NO;
    
    while (superclass.superclass != nil)
    {
        if (superclass == [UIView class])
        {
            isKindOfClass = YES;
            break;
        }
        superclass = superclass.superclass;
    }
    
    if (isKindOfClass == NO)
    {
        NSError *error = [NSError errorWithDomain:@"target 不是 UIView.class 及其子类" code:500 userInfo:@{NSLocalizedDescriptionKey : @"请在 zs_routeTarget 中返回 UIView.class 及其子类"}];
        [self zs_route:route didFail:error];
        return nil;
    }
    
    id<ZSURLRouteOutput> targetView = [targetClass zs_didFinishRouteResult:result];
    
    if ([targetView isKindOfClass:[UIView class]] == NO)
    {
        NSError *error = [NSError errorWithDomain:@"ty_didFinishRouteResult 返回对象类型错误" code:502 userInfo:@{NSLocalizedDescriptionKey : @"请在 zs_didFinishRouteResult 中返回 UIView 及其子类"}];
        [self zs_route:route didFail:error];
        return nil;
    }
    
    return (UIView *)targetView;
}

@end

