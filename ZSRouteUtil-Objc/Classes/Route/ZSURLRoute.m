//
//  ZSURLRoute.m
//  ZSRoute
//
//  Created by Josh on 2021/2/23.
//

#import "ZSURLRoute.h"

@implementation ZSURLRoute

+ (NSString *)zs_removeWhitespacesAndNewlinesLinkFromLink:(NSString *)link {
    
    NSString *_link_ = [link stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    _link_ = [_link_ stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return _link_;
}

@end
