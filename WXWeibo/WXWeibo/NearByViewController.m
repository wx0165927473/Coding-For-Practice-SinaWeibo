//
//  NearByViewController.m
//  WXWeibo
//
//  Created by Wu Xin on 13-5-12.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "NearByViewController.h"
#import "UIImageView+WebCache.h"

@interface NearByViewController ()

@end

@implementation NearByViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isBackButton = NO;
        self.isCancelButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我在这里";
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
    
    [manager stopUpdatingLocation];
    
    if (self.data == nil) {
        float longtitude = newLocation.coordinate.longitude;
        float latitude = newLocation.coordinate.latitude;
        
        NSString *longtitudeString = [NSString stringWithFormat:@"%f",longtitude];
        NSString *latitudeString = [NSString stringWithFormat:@"%f",latitude];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:longtitudeString,@"long",latitudeString,@"lat",nil];
        [self.sinaweibo requestWithURL:@"place/nearby/pois.json" params:params httpMethod:@"GET" delegate:self];
    }
}

#pragma mark - SinaWeiboRequestDelegate delegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    NSArray *pois = [result objectForKey:@"pois"];
    self.data = pois;
    
    [self.tableView reloadData];
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indetify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indetify] autorelease];
    }
    
    NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
    NSString *title = [dic objectForKey:@"title"];
    NSString *address = [dic objectForKey:@"address"];
    NSString *icon = [dic objectForKey:@"icon"];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = address;
    [cell.imageView setImageWithURL:[NSURL URLWithString:icon]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectBlock != nil) {
        NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
        _selectBlock(dic);
        
        Block_release(_selectBlock);
        _selectBlock = nil;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
