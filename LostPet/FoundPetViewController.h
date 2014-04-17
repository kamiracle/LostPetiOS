//
//  FoundPetViewController.h
//  LostPet
//
//  Created by Kyle Miracle on 4/15/14.
//  Copyright (c) 2014 Kamtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoundPetViewController;
@protocol FoundPetViewControllerDelegate <NSObject>
- (void) foundPetViewControllerDidCancel:(FoundPetViewController *)controller;


@end

@interface FoundPetViewController : UIViewController
@property (nonatomic, weak) id <FoundPetViewControllerDelegate> delegate;
- (IBAction)backToMap:(id)sender;

@end
