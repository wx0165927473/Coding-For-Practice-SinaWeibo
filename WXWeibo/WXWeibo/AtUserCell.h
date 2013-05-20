//
//  AtUserCell.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-19.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface AtUserCell : UITableViewCell {
    UIImageView     *_userImage;
}

//微博数据模型对象
@property(nonatomic,retain)UserModel *userModel;
@property(nonatomic,retain)UILabel *nickLabel;
@end
