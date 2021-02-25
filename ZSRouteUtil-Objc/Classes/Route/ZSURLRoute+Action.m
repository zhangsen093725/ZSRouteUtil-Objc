//
//  ZSURLRoute+Action.m
//  ZSRoute
//
//  Created by Josh on 2021/2/23.
//

#import "ZSURLRoute+Action.h"

@implementation ZSURLRoute (Action)

+ (BOOL)zs_setTabbarSelectedController:(UIViewController *)controller {
    
    if (controller.tabBarController == nil) { return NO; }
    
    NSInteger index = [controller.tabBarController.viewControllers indexOfObject:controller];
    
    if (index == NSNotFound) { return NO; }
    
    [controller dismissViewControllerAnimated:NO completion:nil];
    [controller.navigationController popToRootViewControllerAnimated:NO];
    controller.tabBarController.selectedIndex = index;
    
    return YES;
}


+ (UIViewController *)zs_pushFromRoute:(NSString *)route {
    
    return [self zs_pushFromRoute:route animated:YES];
}

+ (UIViewController *)zs_pushFromRoute:(NSString *)route
                              animated:(BOOL)animated {
    
    return [self zs_pushFromRoute:route isCheckTabbar:YES animated:animated];
}

+ (UIViewController *)zs_pushFromRoute:(NSString *)route
                         isCheckTabbar:(BOOL)isCheckTabbar
                              animated:(BOOL)animated {
    
    UIViewController *controller = [self zs_targetControllerFromRoute:route isCheckTabbar:isCheckTabbar];
    
    if (controller == nil) { return nil; }
    
    if (isCheckTabbar)
    {
        if ([self zs_setTabbarSelectedController:controller]) { return controller; }
    }
    
    [[self zs_navigationController] pushViewController:controller animated:animated];
    
    return controller;
}



+ (UIViewController *)zs_popFromRoute:(NSString *)route {
    
    return [self zs_popFromRoute:route animated:YES];
}

+ (UIViewController *)zs_popFromRoute:(NSString *)route
                             animated:(BOOL)animated {
    
    return [self zs_popFromRoute:route isCheckTabbar:YES animated:animated];
}

+ (UIViewController *)zs_popFromRoute:(NSString *)route
                        isCheckTabbar:(BOOL)isCheckTabbar
                             animated:(BOOL)animated {
    
    UIViewController *controller = [self zs_targetControllerFromRoute:route isCheckTabbar:isCheckTabbar];
    
    if (controller == nil) { return nil; }
    
    if (isCheckTabbar)
    {
        if ([self zs_setTabbarSelectedController:controller]) { return controller; }
    }
    
    if ([[self zs_navigationController].viewControllers containsObject:controller])
    {
        [[self zs_navigationController] popToViewController:controller animated:animated];
    }
    
    return controller;
}



+ (UIViewController *)zs_presentFromRoute:(NSString *)route
                               completion:(void (^)(void))completion {
    
    return [self zs_presentFromRoute:route animated:YES completion:completion];
}

+ (UIViewController *)zs_presentFromRoute:(NSString *)route
                                 animated:(BOOL)animated
                               completion:(void (^)(void))completion {
    
    return [self zs_presentFromRoute:route isCheckTabbar:YES animated:animated completion:completion];
}

+ (UIViewController *)zs_presentFromRoute:(NSString *)route
                            isCheckTabbar:(BOOL)isCheckTabbar
                                 animated:(BOOL)animated
                               completion:(nonnull void (^)(void))completion {
    
    UIViewController *controller = [self zs_targetControllerFromRoute:route isCheckTabbar:isCheckTabbar];
    
    if (controller == nil) { return nil; }
    
    if (isCheckTabbar)
    {
        if ([self zs_setTabbarSelectedController:controller]) { return controller; }
    }
    
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [[self zs_presentedController] presentViewController:controller animated:animated completion:completion];
    
    return controller;
}

@end
