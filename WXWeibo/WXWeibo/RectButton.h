//
//  RectButton.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RectButton : UIButton {
    UILabel *_rectTitleLabel;
    UILabel *_subtitleLabel;
}

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;

@end
