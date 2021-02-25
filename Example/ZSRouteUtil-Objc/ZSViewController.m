//
//  ZSViewController.m
//  ZSRouteUtil-Objc
//
//  Created by zhangsen093725 on 02/25/2021.
//  Copyright (c) 2021 zhangsen093725. All rights reserved.
//

#import "ZSViewController.h"
#import "ZSJOSHURLRoute.h"

@interface ZSViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation ZSViewController

+ (id<ZSURLRouteOutput>)zs_didFinishRouteResult:(ZSURLRouteResult *)result {
    
    NSLog(@"scheme: %@", result.scheme);
    NSLog(@"moudle: %@", result.host);
    NSLog(@"submoudle: %@", result.path);
    NSLog(@"params: %@", result.params);
    
    NSLog(@"route: %@", result.route);
    NSLog(@"ignore query: %@", result.ignoreQuery);
    NSLog(@"origin route: %@", result.originRoute);
    
    return [self new];
}

- (UIButton *)button {
    
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"Route" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(on_action:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button];
    }
    return _button;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    self.button.frame = CGRectMake((CGRectGetWidth(self.view.frame) - 150) * 0.5, 100, 150, 60);
}

- (void)on_action:(UIButton *)sender {
    
    NSString *url = [@"https://www.baidu.com?weuu=2iwi&asdjkh=1&q=1" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"].invertedSet];
    
    NSString *route = [NSString stringWithFormat:@"HTTPS://www.view.com/index.html#/haskl/asdajs?qiuu=%@&jklasd=asjd&key = 1&askdhjajkshj&hk=88", url];
    
    [ZSJOSHURLRoute zs_pushFromRoute:route];
}

@end
