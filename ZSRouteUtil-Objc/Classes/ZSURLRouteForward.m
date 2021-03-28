//
//  ZSURLRouteForward.m
//  ZSRoute
//
//  Created by Josh on 2021/2/23.
//

#import "ZSURLRouteForward.h"
#import "ZSURLRoute.h"

@interface ZSURLRouteForward ()

/// 转发目标类，必须是 ZSURLRoute 的子类
@property (nonatomic, assign) Class _target;

@end


@implementation ZSURLRouteForward

- (Class)target {
    
    if (!__target)
    {
        __target = [ZSURLRoute class];
    }
    return __target;
}

- (void)setTarget:(Class)target {
    
    Class superclass = target;
    BOOL isKindOfClass = NO;
    
    while (superclass.superclass != nil)
    {
        if (superclass == [ZSURLRoute class])
        {
            isKindOfClass = YES;
            break;
        }
        superclass = superclass.superclass;
    }
    
    NSAssert(isKindOfClass, @"ZSURLRouteForward 的 target 必须是 ZSURLRoute 的子类");
    __target = target;
}

@end
