//
//  ZSJOSHURLModuleRoute.m
//  ZSRoute_Example
//
//  Created by Josh on 2021/2/24.
//  Copyright © 2021 Tencent. All rights reserved.
//

#import "ZSJOSHURLModuleRoute.h"

@implementation ZSJOSHURLModuleRoute

+ (NSDictionary<NSString *,NSString *> *)zs_schemeMap {
    
    return @{@"http*" : @"web"};
}

+ (NSDictionary<NSString *,NSString *> *)zs_hostMap {
    
    return @{@"www.view.com" : @"view"};
}

+ (NSArray<NSString *> *)zs_ignoreQueryKey {
    
    return @[@"key", @"hk"];
}

+ (NSDictionary<NSString *,NSString *> *)zs_replaceQuery {
    
    return @{
        @"key" : @"hahahahaha",
        @"hk" : @"100"
    };
}

+ (BOOL)zs_ignoreCaseEnable {
    
    return YES;
}

+ (BOOL)zs_filterWhitespacesEnable {
    
    return YES;
}

+ (Class<ZSURLRouteOutput>)zs_routeTargetFromResult:(ZSURLRouteResult *)result {
    
    if ([result.scheme isEqualToString:@"web"])
    {
        return NSClassFromString([NSString stringWithFormat:@"ZS%@Controller", [result.host capitalizedString]]);
    }
    
    return NSClassFromString(@"ZSViewController");
}

@end
