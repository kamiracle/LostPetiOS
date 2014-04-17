//
//  Pet.h
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

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Pet : NSObject

@property (nonatomic) NSInteger petID;
@property (nonatomic, copy) NSString *petName;
@property (nonatomic) CLLocationCoordinate2D lastSeenLocation;
@property (nonatomic, copy) NSDate *lastSeenDate;
@property (nonatomic, copy) NSDate *createdDate;
@property (nonatomic) NSInteger userID;
@property (nonatomic) NSInteger ageInMonths;
@property (nonatomic, copy) NSString *vet;
@property (nonatomic, copy) NSString *favoriteFood;
@property (nonatomic, copy) NSString *houseBroken;
@property (nonatomic, copy) NSString *knownWords;
@property (nonatomic, copy) NSString *approach;
@property (nonatomic, copy) NSString *personality;

-(id) initWithJSONDictionary:(NSDictionary*)jsonDictionary withLastSeenLocation:(CLLocationCoordinate2D)lastSeenLocationCoord;

@end
