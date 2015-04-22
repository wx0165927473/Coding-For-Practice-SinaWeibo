#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NearUserViewController : BaseViewController <SinaWeiboRequestDelegate,CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic, retain) NSArray *data;

@property (retain, nonatomic) IBOutlet MKMapView *mapView;

@end
