//
//  ZSURLRoute+Input.m
//  ZSRoute
//
//  Created by Josh on 2021/2/23.
//

#import "ZSURLRoute+Input.h"

@implementation ZSURLRoute (Input)

+ (NSDictionary<NSString *, NSString *> *)zs_schemeMap {
    
    return @{};
}

+ (NSDictionary<NSString *, NSString *> *)zs_hostMap {
    
    return @{};
}

+ (NSDictionary<NSString *, NSString *> *)zs_pathMap {
    
    return @{};
}

+ (NSDictionary<NSString *, NSString *> *)zs_replaceQuery {
    
    return @{};
}

+ (NSArray<NSString *> *)zs_ignoreQueryKey {
    
    return @[];
}

+ (NSArray<ZSURLRouteForward *> *)zs_forwardList {
    
    return @[];
}

+ (BOOL)zs_forwardEnable {
    
    return NO;
}

+ (BOOL)zs_ignoreCaseEnable {
    
    return NO;
}

+ (BOOL)zs_filterWhitespacesEnable {
    
    return YES;
}

+ (NSDictionary<NSString *, NSString *> *)zs_replaceFromParams:(NSDictionary<NSString *, NSString *> *)params  {
    
    NSMutableDictionary *_params_ = [NSMutableDictionary dictionary];
    [_params_ setDictionary:params];
    
    [[self zs_replaceQuery] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull val, BOOL * _Nonnull stop) {
       
        if (params[key] != nil)
        {
            [_params_ setValue:val forKey:key];
        }
    }];
    
    return [_params_ copy];
}

@end
