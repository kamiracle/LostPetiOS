//
//  MoreViewController.h
//  LostPet
//
//  Created by Kyle Miracle on 4/15/14.
//  Copyright (c) 2014 Kamtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoreViewController;

@protocol MoreViewControllerDelegate <NSObject>
- (void) moreViewControllerDidCancel:(MoreViewController *)controller;


@end

@interface MoreViewController : UIViewController
@property (nonatomic, weak) id <MoreViewControllerDelegate> delegate;
- (IBAction)backToMap:(id)sender;
@end
