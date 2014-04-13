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
#import "AccountTableViewController.h"
#import "ListTableViewController.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, AccountTableViewControllerDelegate, ListTableViewControllerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UITableView* newsTable;
@property (nonatomic, retain) IBOutlet NSMutableArray *newsDataForTable;
@property (weak, nonatomic) IBOutlet UITextField *searchText;

- (IBAction)textFieldReturn:(id)sender;
- (void)changeMapType:(id)sender;
- (void)addAnnotationToMap:(NSString*)petName withCoordinate:(CLLocationCoordinate2D)coord;
@end
