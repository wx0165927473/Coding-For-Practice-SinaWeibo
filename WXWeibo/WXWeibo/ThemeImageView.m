//
//  ThemeImageView.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-22.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"

@implementation ThemeImageView

- (void)dealloc {
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//使用xib创建后，调用的初始化方法
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNofication object:nil];
}

- (id)initWithImageName:(NSString *)imageName {
    self = [self init];
    if (self != nil) {
        self.imageName = imageName;
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        //监听主题切换通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNofication object:nil];
    }
    return self;
}

- (void)setImageName:(NSString *)imageName {
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName copy];
    }
    
    [self loadThemeImage];
}

//加载当前主题下对应的图片
- (void)loadThemeImage {
    if (self.imageName == nil) {
        return;
    }
    
    UIImage *image = [[ThemeManager shareInstance] getThemeImage:_imageName];
    image = [image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    self.image = image;
}

//主题切换的通知
#pragma mark - NSNotification actions
- (void)themeNotification:(NSNotification *)notification {
    [self loadThemeImage];
}

@end
