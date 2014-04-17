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
#import "LostPetViewController.h"
#import "FoundPetViewController.h"
#import "MoreViewController.h"
#import "Pet.h"
#import "PetDetailViewController.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, AccountTableViewControllerDelegate, ListTableViewControllerDelegate, FoundPetViewControllerDelegate, LostPetViewControllerDelegate, MoreViewControllerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UITableView* newsTable;
@property (nonatomic, retain) IBOutlet NSMutableArray *newsDataForTable;
@property (weak, nonatomic) IBOutlet UITextField *searchText;

- (IBAction)textFieldReturn:(id)sender;
- (void)changeMapType:(id)sender;
- (void)addPetAnnotationToMap:(Pet*)pet;
@end
