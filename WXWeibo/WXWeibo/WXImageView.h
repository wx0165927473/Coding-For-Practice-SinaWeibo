//
//  WXImageView.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

//点击头像 进入详情页面
typedef void(^ImageBlock)(void);

@interface WXImageView : UIImageView

@property (nonatomic,copy) ImageBlock touchBlock;

@end
