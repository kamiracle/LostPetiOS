//
//  MVViewController.m
//  MapView
//
//  Created by dev27 on 5/30/13.
//  Copyright (c) 2013 codigator. All rights reserved.
//

#import "MVViewController.h"
#import "myAnnotation.h"
#import "CalloutView.h"

#define METERS_PER_MILE 1609.344

@interface MVViewController ()

@end

@implementation MVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  //4
  self.mapView.delegate = self;
  //5
  CLLocationCoordinate2D coordinate1;
  coordinate1.latitude = 40.740384;
  coordinate1.longitude = -73.991146;
  myAnnotation *annotation = [[myAnnotation alloc] initWithCoordinate:coordinate1 title:@"Starbucks NY"];
  [self.mapView addAnnotation:annotation];
  
  CLLocationCoordinate2D coordinate2;
  coordinate2.latitude = 40.741623;
  coordinate2.longitude = -73.992021;
  myAnnotation *annotation2 = [[myAnnotation alloc] initWithCoordinate:coordinate2 title:@"Pascal Boyer Gallery"];
  [self.mapView addAnnotation:annotation2];
  
  CLLocationCoordinate2D coordinate3;
  coordinate3.latitude = 40.739490;
  coordinate3.longitude = -73.991154;
  myAnnotation *annotation3 = [[myAnnotation alloc] initWithCoordinate:coordinate3 title:@"Virgin Records"];
  [self.mapView addAnnotation:annotation3];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  //1
  CLLocationCoordinate2D zoomLocation;
  zoomLocation.latitude = 40.740848;
  zoomLocation.longitude= -73.991145;
  // 2
  MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.2*METERS_PER_MILE, 0.2*METERS_PER_MILE);
  [self.mapView setRegion:viewRegion animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -MapView Delegate Methods
//6
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  if([annotation isKindOfClass:[MKUserLocation class]]) {
    return nil;
  }
 //7
  static NSString *identifier = @"myAnnotation"; 
  MKAnnotationView * annotationView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
  if (!annotationView)
        {
          annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
          //10
          annotationView.image = [UIImage imageNamed:@"pin.png"];
        }else {
          annotationView.annotation = annotation;
        }
  return annotationView;
}

//11
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
  if(![view.annotation isKindOfClass:[MKUserLocation class]]) {
    CalloutView *calloutView = (CalloutView *)[[[NSBundle mainBundle] loadNibNamed:@"calloutView" owner:self options:nil] objectAtIndex:0];
    CGRect calloutViewFrame = calloutView.frame;
    calloutViewFrame.origin = CGPointMake(-calloutViewFrame.size.width/2 + 15, -calloutViewFrame.size.height);
    calloutView.frame = calloutViewFrame;
    [calloutView.calloutLabel setText:[(myAnnotation*)[view annotation] title]];
    [view addSubview:calloutView];
  } 
  
}

//12
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
  for (UIView *subview in view.subviews ){
    [subview removeFromSuperview];
  }
}

@end
