//
//  UserAnnotation.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-16.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "UserModel.h"

@interface UserAnnotation : NSObject <MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, retain) UserModel *userModel;

- (id)initWithUserModel:(UserModel *)userModel;
@end
