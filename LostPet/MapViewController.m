//
//  MapViewController.m
//  LostPet
//
//  Created by Kyle Miracle on 4/12/14.
//  Copyright (c) 2014 Kamtech. All rights reserved.
//

#import "MapViewController.h"
#define weburl @"http://localhost:5000/api/pets"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize newsTable = _newsTable;
@synthesize newsDataForTable = _newsDataForTable;

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
    // Do any additional setup after loading the view.
    MKUserLocation *userLocation = _mapView.userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 2000, 2000);
    [_mapView setRegion:region animated:NO];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    
    [self fetchRestData];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    _mapView.centerCoordinate = userLocation.location.coordinate;
    NSLog(@"Current coord %f %f", userLocation.location.coordinate.latitude,
                                  userLocation.location.coordinate.longitude);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changeMapType:(id)sender {
    if (_mapView.mapType == MKMapTypeStandard) {
        _mapView.mapType = MKMapTypeSatellite;
    } else {
        _mapView.mapType = MKMapTypeStandard;
    }
}

- (void)addAnnotationToMap:(id)sender {
    CLLocationCoordinate2D coordinate1 = _mapView.userLocation.location.coordinate;
    PetAnnotation *newAnnotation = [[PetAnnotation alloc] initWithCoordinate:coordinate1 title:@"First Try"];
}

- (void)fetchRestData; {
    NSURL *url = [NSURL URLWithString:weburl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary *rest_data = [NSJSONSerialization JSONObjectWithData:data
                                                                                             options:0
                                                                                               error:NULL];
                                   
                                   _newsDataForTable = [NSMutableArray array];
                                   NSDictionary *news;
                                   for (id key in rest_data[@"_embedded"]) {
                                       news = [rest_data[@"_embedded"] objectForKey:key];
                                   }
                                   
                                   
                                   int iterator = 0;
                                   for (id key in news) {
                                       [_newsDataForTable insertObject:key[@"title"] atIndex:iterator];
                                       iterator++;
                                   }
                                   
                                   [_newsTable reloadData];
                                   [_newsTable numberOfRowsInSection:[_newsDataForTable count]];
                                   [_newsTable reloadRowsAtIndexPaths:0 withRowAnimation:UITableViewRowAnimationLeft];
                               }
                               
                           }];
}
@end
