#import "WeiboAnnotation.h"

@implementation WeiboAnnotation

- (id)initWithWeiboModel:(WeiboModel *)weiboModel {
    self = [super init];
    if (self) {
        self.weiboModel = weiboModel;
    }
    
    return self;
}

- (void)setWeiboModel:(WeiboModel *)weiboModel {
    if (_weiboModel != weiboModel) {
        [_weiboModel release];
        _weiboModel = [weiboModel retain];
    }
    
    NSDictionary *geoDic = weiboModel.geo;
    if ([geoDic isKindOfClass:[NSDictionary class]]) {
        NSArray *geoArray = [geoDic objectForKey:@"coordinates"];
        
        if (geoArray.count == 2) {
            float longitude = [[geoArray objectAtIndex:1] floatValue];
            float latitude = [[geoArray objectAtIndex:0] floatValue];
            _coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        }
    }

}

@end
