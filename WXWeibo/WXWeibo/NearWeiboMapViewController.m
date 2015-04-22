#import "NearWeiboMapViewController.h"
#import "WeiboModel.h"
#import "WeiboAnnotation.h"
#import "WeiboAnnotationView.h"

@interface NearWeiboMapViewController ()

@end

@implementation NearWeiboMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
    
    [manager stopUpdatingLocation];
    
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    
	MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region animated:YES];
    
    if (self.data == nil) {
        NSString *longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
        NSString *latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:longitude,@"long",latitude,@"lat", nil];
        

        [self.sinaweibo requestWithURL:@"place/nearby_timeline.json" params:params httpMethod:@"GET" delegate:self];

    }
}

#pragma mark - SinaWeiboRequest
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    //附近的微博

        NSArray *statues = [result objectForKey:@"statuses"];
        NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
        for (int i=0; i<statues.count; i++) {
            NSDictionary *statusDic = [statues objectAtIndex:i];
            WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statusDic];
            [weibos addObject:weibo];
            [weibo release];
            
            //创建Anatation对象，添加到地图上
            WeiboAnnotation *weiboAnnotation = [[WeiboAnnotation alloc] initWithWeiboModel:weibo];
            [self.mapView performSelector:@selector(addAnnotation:) withObject:weiboAnnotation afterDelay:i*0.1];
            [weiboAnnotation release];
        }
}

#pragma mark - MKAnnotationView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *indentify = @"WeiboAnnotationView";
    WeiboAnnotationView *weiboAnnotationView = (WeiboAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:indentify];
    if (weiboAnnotationView == nil) {
        weiboAnnotationView = [[[WeiboAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:indentify] autorelease];
    }
    
    return weiboAnnotationView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    for (UIView *annotationView in views) {
        CGAffineTransform transform = annotationView.transform;
        annotationView.transform = CGAffineTransformScale(transform, 0.7, 0.7);
        annotationView.alpha = 0;
        
        [UIView animateWithDuration:0.4 animations:^{
            annotationView.transform = CGAffineTransformScale(transform, 1.3, 1.3);
            annotationView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4 animations:^{
                annotationView.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

- (void)dealloc {
    [_mapView release];
    [super dealloc];
}

@end
