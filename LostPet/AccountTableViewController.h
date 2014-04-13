//
//  AccountTableViewController.h
//  LostPet
//
//  Created by Kyle Miracle on 4/13/14.
//  Copyright (c) 2014 Kamtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccountTableViewController;
@protocol AccountTableViewControllerDelegate <NSObject>
- (void)accountTableViewControllerDidCancel:(AccountTableViewController *)controller;


@end

@interface AccountTableViewController : UITableViewController

@property (nonatomic, weak) id <AccountTableViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;

@end
