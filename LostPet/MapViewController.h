//
//  MapViewController.h
//  LostPet
//
//  Created by Kyle Miracle on 4/12/14.
//  Copyright (c) 2014 Kamtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PetAnnotation.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UITableView* newsTable;
@property (nonatomic, retain) IBOutlet NSMutableArray *newsDataForTable;

- (void)changeMapType:(id)sender;
- (void)addAnnotationToMap:(id)sender;

@end
