#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        _url = [url retain];
    }
    
    return self;
}

- (IBAction)goBack:(id)sender {
    if (_webView.canGoBack) {
        [_webView goBack];
    }
}

- (IBAction)goForward:(id)sender {
    if (_webView.canGoForward) {
        [_webView goForward];
    }
}

- (IBAction)reload:(id)sender {
    [_webView reload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    self.title = @"载入中...";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

#pragma mark - UIWebView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}


- (void)dealloc {
    [_webView release];
    [super dealloc];
}
@end
