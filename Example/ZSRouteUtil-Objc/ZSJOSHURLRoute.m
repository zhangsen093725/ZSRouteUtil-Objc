//
//  ZSJOSHURLRoute.m
//  ZSRoute_Example
//
//  Created by Josh on 2021/2/24.
//  Copyright © 2021 Tencent. All rights reserved.
//

#import "ZSJOSHURLRoute.h"
#import "ZSJOSHURLModuleRoute.h"

@implementation ZSJOSHURLRoute

+ (BOOL)zs_forwardEnable {
    
    return YES;
}

+ (BOOL)zs_ignoreCaseEnable {
    
    return YES;
}

+ (NSArray<ZSURLRouteForward *> *)zs_forwardList {
    
    ZSURLRouteForward *forward = [ZSURLRouteForward new];
    forward.host = @"www.***.com";
    forward.path = @"*/*/*";
    forward.target = ZSJOSHURLModuleRoute.class;
    
    return @[forward];
}

@end
