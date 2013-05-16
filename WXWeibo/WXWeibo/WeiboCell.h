//
//  WeiboCell.h
//  WXWeibo
//  自定义微博cell
//  Created by wei.chen on 13-1-23.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiboModel;
@class WeiboView;
@class WXImageView;
@interface WeiboCell : UITableViewCell {
    WXImageView     *_userImage;    //用户头像视图
    UILabel         *_nickLabel;    //昵称
    UILabel         *_repostCountLabel; //转发数
    UILabel         *_commentLabel;     //回复数
    UILabel         *_sourceLabel;      //发布来源
    UILabel         *_createLabel;      //发布时间
}

//微博数据模型对象
@property(nonatomic,retain)WeiboModel *weiboModel;
//微博视图
@property(nonatomic,retain)WeiboView *weiboView;

@end
