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
