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
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 5000, 5000);
    [_mapView setRegion:region animated:NO];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    
    [self fetchRestData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AccountSettings"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AccountTableViewController *accountTableViewController = [navigationController viewControllers][0];
        accountTableViewController.delegate = self;
        
    } else if ([segue.identifier isEqualToString:@"ListView"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ListTableViewController *listTableViewController = [navigationController viewControllers][0];
        listTableViewController.delegate = self;
    }
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

#pragma mark - AccountTableViewControllerDelegate

- (void)accountTableViewControllerDidCancel:(AccountTableViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listTableViewControllerDidCancel:(ListTableViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)changeMapType:(id)sender {
    if (_mapView.mapType == MKMapTypeStandard) {
        _mapView.mapType = MKMapTypeSatellite;
    } else {
        _mapView.mapType = MKMapTypeStandard;
    }
}

- (void)addAnnotationToMap:(NSString*)petName withCoordinate:(CLLocationCoordinate2D)coord {
    PetAnnotation *newAnnotation = [[PetAnnotation alloc] initWithCoordinate:coord title:petName];
    
    
    [_mapView addAnnotation:newAnnotation];
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
                                   
                                   for (id key in rest_data[@"pets"]) {
                                       //news = [rest_data[@"_embedded"] objectForKey:key];
                                       NSLog(@"NEW PET: %@", key[@"pet_name"]);
                                       NSLog(@"Last Loc: %@", key[@"last_seen_loc"]);
                                       
                                       // Split the last_seen_loc
                                       NSArray *splitCoord = [key[@"last_seen_loc"] componentsSeparatedByString:@(" ")];
                                       NSString *lon = [splitCoord[0] stringByReplacingOccurrencesOfString:@"POINT(" withString:@"" ];
                                       NSString *lat = [splitCoord[1] stringByReplacingOccurrencesOfString:@")" withString:@"" ];

                                       CLLocationCoordinate2D coord;
                                       CLLocationDegrees latDegrees = [lat doubleValue];
                                       CLLocationDegrees lonDegrees = [lon doubleValue];
                                       
                                       coord.latitude = latDegrees;
                                       coord.longitude = lonDegrees;
                                       
                                       NSLog(@"%f ::: %f", coord.latitude, coord.longitude);
                                       
                                       [self addAnnotationToMap:key[@"pet_name"]
                                                 withCoordinate:coord];
                                       
                                   }
                                   
                                   /*int iterator = 0;
                                   for (id key in news) {
                                       [_newsDataForTable insertObject:key[@"title"] atIndex:iterator];
                                       iterator++;
                                   }*/
                                   
                               } else {
                                   NSLog(@"Connection Error");
                               }
                               
                           }];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation {
    //7
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    //8
    static NSString *identifier = @"myAnnotation";
    MKPinAnnotationView * annotationView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView)
    {
        //9
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.pinColor = MKPinAnnotationColorGreen;
        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
    }else {
        annotationView.annotation = annotation;
    }
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}

- (void)mapView:(MKMapView *)_mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"Clicked %@", view.annotation.title);
}
@end
