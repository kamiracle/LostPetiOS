//
//  ListTableViewController.h
//  LostPet
//
//  Created by Kyle Miracle on 4/13/14.
//  Copyright (c) 2014 Kamtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListTableViewController;
@protocol ListTableViewControllerDelegate <NSObject>
- (void)listTableViewControllerDidCancel:(ListTableViewController *)controller;


@end

@interface ListTableViewController : UITableViewController
@property (nonatomic, weak) id <ListTableViewControllerDelegate> delegate;
- (IBAction)backToMap:(id)sender;

@end
