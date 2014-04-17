//
//  MapViewController.m
//  LostPet
//
//  Created by Kyle Miracle on 4/12/14.
//  Copyright (c) 2014 Kamtech. All rights reserved.
//

#import "MapViewController.h"
#define weburl @"http://192.168.1.12:5000/api/pets"

@interface MapViewController ()

@end

@implementation MapViewController

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
    } else if ([segue.identifier isEqualToString:@"FoundPetView"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        FoundPetViewController *foundPetViewController = [navigationController viewControllers][0];
        foundPetViewController.delegate = self;
    } else if ([segue.identifier isEqualToString:@"LostPetView"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        LostPetViewController *lostPetViewController = [navigationController viewControllers][0];
        lostPetViewController.delegate = self;
    } else if ([segue.identifier isEqualToString:@"MoreView"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        MoreViewController *moreViewController = [navigationController viewControllers][0];
        moreViewController.delegate = self;
    }
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    _mapView.centerCoordinate = userLocation.location.coordinate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)accountTableViewControllerDidCancel:(AccountTableViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listTableViewControllerDidCancel:(ListTableViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)foundPetViewControllerDidCancel:(FoundPetViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)lostPetViewControllerDidCancel:(LostPetViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)moreViewControllerDidCancel:(MoreViewController *)controller
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
                                       // Split the last_seen_loc
                                       NSArray *splitCoord = [key[@"last_seen_loc"] componentsSeparatedByString:@(" ")];
                                       NSString *lon = [splitCoord[0] stringByReplacingOccurrencesOfString:@"POINT(" withString:@"" ];
                                       NSString *lat = [splitCoord[1] stringByReplacingOccurrencesOfString:@")" withString:@"" ];

                                       CLLocationCoordinate2D coord;
                                       CLLocationDegrees latDegrees = [lat doubleValue];
                                       CLLocationDegrees lonDegrees = [lon doubleValue];
                                       
                                       coord.latitude = latDegrees;
                                       coord.longitude = lonDegrees;
                                       
                                       NSDictionary *petDictionary = [[NSDictionary alloc] init];
                                       petDictionary = key;
                                       
                                       
                                       Pet *newPet = [[Pet alloc] initWithJSONDictionary:petDictionary
                                                                    withLastSeenLocation:coord];
                                       
                                       [self addPetAnnotationToMap:newPet];
                                       
                                   }
                                   
                               } else {
                                   NSLog(@"Connection Error");
                               }
                               
                           }];
}

- (void)addPetAnnotationToMap:(Pet*)pet
{
    PetAnnotation *newAnnotation = [[PetAnnotation alloc] initWithCoordinate:pet.lastSeenLocation
                                                                       title:pet.petName
                                                                    subTitle:pet.personality
                                                                     withPet:pet];
    [_mapView addAnnotation:newAnnotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation {
    
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *identifier = @"myAnnotation";
    MKPinAnnotationView * annotationView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView)
    {
        
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.pinColor = MKPinAnnotationColorGreen;
        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
        
        UIImageView *petThumbnail = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dog.png"]];
        [petThumbnail setFrame:CGRectMake(0,0,50,50)];
        petThumbnail.contentMode = UIViewContentModeScaleAspectFill;
        annotationView.leftCalloutAccessoryView = petThumbnail;
        
    }else {
        annotationView.annotation = annotation;
    }
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}


- (void)mapView:(MKMapView *)_mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"Clicked %@", view.annotation.title);
    PetAnnotation *petAnnotation = view.annotation;
    PetDetailViewController *newVC = [[PetDetailViewController alloc] initWithPet:petAnnotation.pet];
    [self.navigationController pushViewController:newVC animated:YES];
}
@end
