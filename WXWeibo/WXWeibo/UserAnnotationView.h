//
//  UserAnnotationView.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-16.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "UserModel.h"

@interface UserAnnotationView : MKAnnotationView {
    UIImageView *userImage;     //用户头像
}

@property (nonatomic,retain)    UserModel *userModel;

@end
