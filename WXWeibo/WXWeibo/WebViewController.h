//
//  WebViewController.h
//  WXWeibo
//
//  Created by Wu Xin on 13-5-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate> {
    NSString *_url;
}

@property (retain, nonatomic) IBOutlet UIWebView *webView;

- (id)initWithUrl:(NSString *)url;

- (IBAction)goBack:(id)sender;
- (IBAction)goForward:(id)sender;
- (IBAction)reload:(id)sender;
@end
