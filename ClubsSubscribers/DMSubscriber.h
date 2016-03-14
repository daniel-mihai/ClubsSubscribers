//
//  DMSubscriber.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityModelProtocol.h"
#define TAGS_SEPARATOR @"##"

@interface DMSubscriber : NSObject<EntityModelProtocol>

@property (strong, readonly) NSString           *itemId;
@property (strong, readonly) NSString           *name;
@property (strong, readonly) NSString           *clubId;
@property (strong, readonly) NSString           *eyeColor;
@property (assign, readonly) int                age;
@property (assign, readonly) BOOL               isActive;
@property (strong, readonly) NSString           *gender;
@property (strong, readonly) NSString           *company;
@property (strong, readonly) NSString           *email;
@property (strong, readonly) NSString           *phone;
@property (strong, readonly) NSString           *address;
@property (strong, readonly) NSString           *about;
@property (strong, readonly) NSString           *registered;
@property (strong, readonly) NSString           *tags;
@property (strong, readonly) NSString           *greeting;
@property (strong, readonly) NSString           *favoriteFruit;


@end
