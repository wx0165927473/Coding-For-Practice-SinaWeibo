//
//  UIView+Additions.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)
//利用UIResponder传递机制，找到viewController push到下一个页面
- (UIViewController *)viewController {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}
@end
