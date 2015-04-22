#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WeiboModel.h"

@interface WeiboAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, retain) WeiboModel *weiboModel;


- (id)initWithWeiboModel:(WeiboModel *)weiboModel;
@end
