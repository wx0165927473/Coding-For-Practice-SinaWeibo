//
//  ThemeLabel.h
//  WXWeibo
//
//  Created by wei.chen on 13-1-22.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeLabel : UILabel

@property(nonatomic,copy)NSString *colorName;

- (id)initWithColorName:(NSString *)colorName;

@end
