//
//  PetDetailViewController.m
//  LostPet
//
//  Created by Kyle Miracle on 4/16/14.
//  Copyright (c) 2014 Kamtech. All rights reserved.
//

#import "PetDetailViewController.h"

@interface PetDetailViewController ()

@end

@implementation PetDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithPet:(Pet *)pet
{
    self = [super init];
    if (self) {
        self.pet = pet;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Pet *pet = self.pet;
    
    self.petNameLabel.text = pet.petName;
    self.personality.text = pet.personality;
    //self.approach.text = pet.approach;
    self.knownWords.text = pet.knownWords;
    self.favoriteFood.text = pet.favoriteFood;
    self.petAge.text = [NSString stringWithFormat:@"%ld", (long)pet.ageInMonths];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
