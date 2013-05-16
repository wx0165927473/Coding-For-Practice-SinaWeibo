//
//  WXFaceView.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-14.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBlock)(NSString *);

@interface WXFaceView : UIView {
 @private
    NSMutableArray *items;
    UIImageView *magnifierView;
}

@property (nonatomic, copy) NSString *selectedFaceName; //记下选中表情的名称
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, copy) SelectBlock block;
@end
