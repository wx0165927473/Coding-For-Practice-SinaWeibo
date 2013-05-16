//
//  ThemeLabel.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-22.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"

@implementation ThemeLabel

- (void)dealloc {
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_colorName release];
}

- (id)init {
    self = [super init];
    if (self != nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNofication object:nil];
    }
    return self;
}

- (id)initWithColorName:(NSString *)colorName {
    self = [self init];
    if (self != nil) {
        self.colorName = colorName;
    }
    return self;
}

- (void)setColorName:(NSString *)colorName {
    if (_colorName != colorName) {
        [_colorName release];
        _colorName = [colorName copy];
    }
    
    [self setColor];
}

- (void)setColor {
    UIColor *textColor = [[ThemeManager shareInstance] getColorWithName:_colorName];
    self.textColor = textColor;
}

#pragma mark - NSNotification actions
- (void)themeNotification:(NSNotification *)notification {
    [self setColor];
}

@end
