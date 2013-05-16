//
//  WeiboAnnotationView.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-16.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "WeiboAnnotation.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>

@implementation WeiboAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    userImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    userImage.layer.borderWidth = 1;
    
    weiboImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    weiboImage.backgroundColor = [UIColor blackColor];
    
    textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    textLabel.font = [UIFont systemFontOfSize:12.0f];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.numberOfLines = 3;
    
    [self addSubview:weiboImage];
    [self addSubview:textLabel];
    [self addSubview:userImage];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    WeiboAnnotation *weiboAnnotation = self.annotation;
    WeiboModel *weiboModel = nil;
    if ([weiboAnnotation isKindOfClass:[WeiboAnnotation class]]) {
        weiboModel = weiboAnnotation.weiboModel;
    }
    
    NSString *weiboImageURL = weiboModel.thumbnailImage;
    if (weiboImageURL.length > 0) { //带微博图片
        self.image = [UIImage imageNamed:@"nearby_map_photo_bg.png"];
        
        //加载微博图片
        weiboImage.frame = CGRectMake(15, 15, 90, 85);
        [weiboImage setImageWithURL:[NSURL URLWithString:weiboImageURL]];
        
        //加载用户头像
        userImage.frame = CGRectMake(70, 70, 30, 30);
        NSString *userImageURL = weiboModel.user.profile_image_url;
        [userImage setImageWithURL:[NSURL URLWithString:userImageURL]];
        
        textLabel.hidden = YES;
        weiboImage.hidden = NO;
    }else {   //不带微博图片
        self.image = [UIImage imageNamed:@"nearby_map_content.png"];
        
        //加载用户头像
        userImage.frame = CGRectMake(20, 20, 45, 45);
        NSString *userImageURL = weiboModel.user.profile_image_url;
        [userImage setImageWithURL:[NSURL URLWithString:userImageURL]];
        
        //加载微博内容
        textLabel.frame = CGRectMake(userImage.right+5, userImage.top, 110, 45);
        textLabel.text = weiboModel.text;
        
        textLabel.hidden = NO;
        weiboImage.hidden = YES;
    }
}

@end
