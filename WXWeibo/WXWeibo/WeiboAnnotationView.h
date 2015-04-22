#import <MapKit/MapKit.h>

@interface WeiboAnnotationView : MKAnnotationView {
    UIImageView *userImage;     //用户头像
    UIImageView *weiboImage;    //微博图片
    UILabel *textLabel;         //微博内容
}

@end
