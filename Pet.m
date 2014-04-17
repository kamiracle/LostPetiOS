//
//  Pet.m
//  LostPet
//
//  Created by Kyle Miracle on 4/15/14.
//  Copyright (c) 2014 Kamtech. All rights reserved.
//

/*
 'id': self.id,
 'pet_name': self.name,
 'last_seen_loc': db_session.scalar(self.last_seen_loc.wkt),
 'search_polygon': db_session.scalar(self.search_polygon.wkt),
 'last_seen_date': dump_datetime(self.last_seen_date),
 'created': dump_datetime(self.created),
 'user_id': self.user_id,
 'age': self.age,
 'vet': self.vet,
 'fav_food': self.fav_food,
 'known_words': self.known_words,
 'house_broken': self.house_broken,
 'approach': self.approach,
 'personality': self.personality,
 */

#import "Pet.h"

@implementation Pet

-(id) initWithJSONDictionary:(NSDictionary *)jsonDictionary withLastSeenLocation:(CLLocationCoordinate2D)lastSeenLocationCoord
{
    if (self = [super init]) {
        self.petName = jsonDictionary[@"pet_name"];
        self.petID = [jsonDictionary[@"id"] integerValue];
        self.lastSeenLocation = lastSeenLocationCoord;
        self.createdDate = jsonDictionary[@"created"];
        self.userID = [jsonDictionary[@"user_id"] integerValue];
        self.ageInMonths = [jsonDictionary[@"age"] integerValue];
        self.vet = jsonDictionary[@"vet"];
        self.favoriteFood = jsonDictionary[@"fav_food"];
        self.knownWords = jsonDictionary[@"known_words"];
        self.houseBroken = jsonDictionary[@"house_broken"];
        self.approach = jsonDictionary[@"approach"];
        self.personality = jsonDictionary[@"personality"];
    }
    
    return self;
}

@end
