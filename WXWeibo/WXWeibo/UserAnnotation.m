//
//  UserAnnotation.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-16.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UserAnnotation.h"

@implementation UserAnnotation
- (id)initWithUserModel:(UserModel *)userModel {
    self = [super init];
    if (self) {
        self.userModel = userModel;
    }
    
    return self;
}

- (void)setUserModel:(UserModel *)userModel {
    if (_userModel != userModel) {
        [_userModel release];
        _userModel = [userModel retain];
    }
    
    NSDictionary *locations = [(NSDictionary *)self.userModel.status objectForKey:@"annotations"];
    for (NSDictionary *dic in locations) {
        NSDictionary *place = [dic objectForKey:@"place"];
        NSString *lat = [place objectForKey:@"lat"];
        NSString *lon = [place objectForKey:@"lon"];
        
        float longitude = [lon floatValue];
        float latitude = [lat floatValue];
        
        _coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    }
}

@end
