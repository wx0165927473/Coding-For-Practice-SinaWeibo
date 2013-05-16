//
//  UIFactory.h
//  WXWeibo
//  主题控件工厂类

//  Created by wei.chen on 13-1-22.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"

@interface UIFactory : NSObject

//创建button
+ (ThemeButton *)createButton:(NSString *)imageName highlighted:(NSString *)highlightedName;
+ (ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName
                                backgroundHighlighted:(NSString *)highlightedName;

//创建ImageView
+ (ThemeImageView *)createImageView:(NSString *)imageName;

//创建Label
+ (ThemeLabel *)createLabel:(NSString *)colorName;

//根据主题创建Navigation Button
+ (UIButton *)createNavigationButton:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action;
@end
