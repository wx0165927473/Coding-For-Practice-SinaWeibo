//
//  UIFactory.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-22.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

//根据主题创建按钮
+ (ThemeButton *)createButton:(NSString *)imageName highlighted:(NSString *)highlightedName {
    ThemeButton *button = [[ThemeButton alloc] initWithImage:imageName highlighted:highlightedName];
    return [button autorelease];
}

//根据主题创建有背景的按钮
+ (ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName
                      backgroundHighlighted:(NSString *)highlightedName {
    ThemeButton *button = [[ThemeButton alloc] initWithBackground:backgroundImageName highlightedBackground:highlightedName];
    return [button autorelease];
}

//根据主题创建ImageView
+ (ThemeImageView *)createImageView:(NSString *)imageName {
    ThemeImageView *themeImage = [[ThemeImageView alloc] initWithImageName:imageName];
    return [themeImage autorelease];
}

//根据主题创建Label
+ (ThemeLabel *)createLabel:(NSString *)colorName {
    ThemeLabel *themeLabel = [[ThemeLabel alloc] initWithColorName:colorName];
    return [themeLabel autorelease];
}

//根据主题创建Navigation Button
+ (UIButton *)createNavigationButton:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action {
    ThemeButton *button = [self createButtonWithBackground:@"navigationbar_button_background.png" backgroundHighlighted:@"navigationbar_button_delete_background.png"];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.leftCapWidth = 3;
    
    return button;
}
@end
