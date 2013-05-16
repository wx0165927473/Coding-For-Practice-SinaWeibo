//
//  DetailViewController.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-3.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import "CommentTableView.h"
@class WeiboModel;
@class WeiboView;
@interface DetailViewController : BaseViewController<UITableViewEventDelegate,SinaWeiboRequestDelegate> {
    WeiboView *_weiboView;
}


@property (retain, nonatomic) WeiboModel *weiboModel;
@property (retain, nonatomic) IBOutlet CommentTableView *tableView;
@property (retain, nonatomic) IBOutlet UIImageView *userImageView;
@property (retain, nonatomic) IBOutlet UILabel *nickLabel;
@property (retain, nonatomic) IBOutlet UIView *userBarView;

@property (nonatomic,copy) NSString *lastCommentId; //最后一条评论的id
@property (nonatomic,retain) SinaWeiboRequest *request; //区分request tag
@property (nonatomic,retain) NSMutableArray *weibos;
@end
