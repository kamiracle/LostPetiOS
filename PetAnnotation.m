//
//  PetAnnotation.m
//  LostPet
//
//  Created by Kyle Miracle on 4/12/14.
//  Copyright (c) 2014 Kamtech. All rights reserved.
//

#import "PetAnnotation.h"

@implementation PetAnnotation

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title
{
    if ((self = [super init])) {
        self.coordinate =coordinate;
        self.title = title;
        
    }
    return self;
}

@end
