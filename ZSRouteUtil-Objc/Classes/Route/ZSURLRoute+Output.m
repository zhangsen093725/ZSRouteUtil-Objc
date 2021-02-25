//
//  ZSURLRoute+Output.m
//  ZSRoute
//
//  Created by Josh on 2021/2/23.
//

#import "ZSURLRoute+Output.h"

@implementation ZSURLRoute (Output)

+ (BOOL)zs_logEnable {
    
    return YES;
}

+ (Class<ZSURLRouteOutput>)zs_routeTargetFromResult:(ZSURLRouteResult *)result {
    
    return nil;
}

+ (void)zs_route:(NSString *)route didFail:(NSError *)error {
    
    if ([self zs_logEnable] == false) { return; }
    
    NSLog(@"------------ZSURLRoute route fail begin------------");
    NSLog(@"Exception: Router '%@' ", route);
    NSLog(@"error: %@", error);
    NSLog(@"------------ZSURLRoute route fail end--------------");
}

@end
