//
//  WeiboAnnotationView.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-16.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface WeiboAnnotationView : MKAnnotationView {
    UIImageView *userImage;     //用户头像
    UIImageView *weiboImage;    //微博图片
    UILabel *textLabel;         //微博内容
}

@end
