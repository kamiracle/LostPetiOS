//
//  PetDetailViewController.h
//  LostPet
//
//  Created by Kyle Miracle on 4/16/14.
//  Copyright (c) 2014 Kamtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pet.h"
#import "PetAnnotation.h"


@interface PetDetailViewController : UIViewController

-(id) initWithPet:(Pet*)pet;
@property (weak, nonatomic) IBOutlet UILabel *petNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastSeenLocation;
@property (weak, nonatomic) IBOutlet UILabel *personality;
@property (weak, nonatomic) IBOutlet UILabel *approach;
@property (weak, nonatomic) IBOutlet UIImageView *petImage;
@property (nonatomic, strong) Pet *pet;
@property (weak, nonatomic) IBOutlet UILabel *petOwner;
@property (weak, nonatomic) IBOutlet UILabel *petAge;
@property (weak, nonatomic) IBOutlet UILabel *knownWords;
@property (weak, nonatomic) IBOutlet UILabel *favoriteFood;

@end
