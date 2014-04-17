//
//  MVViewController.h
//  MapView
//
//  Created by dev27 on 5/30/13.
//  Copyright (c) 2013 codigator. All rights reserved.
// mapkit.framework import and include

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MVViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
