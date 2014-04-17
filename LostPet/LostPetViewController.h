//
//  LostPetViewController.h
//  LostPet
//
//  Created by Kyle Miracle on 4/15/14.
//  Copyright (c) 2014 Kamtech. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LostPetViewController;

@protocol LostPetViewControllerDelegate <NSObject>
- (void) lostPetViewControllerDidCancel:(LostPetViewController *)controller;


@end

@interface LostPetViewController : UIViewController
@property (nonatomic, weak) id <LostPetViewControllerDelegate> delegate;
- (IBAction)backToMap:(id)sender;

@end
