//
//  DMClub.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityModelProtocol.h"

@interface DMClub : NSObject<EntityModelProtocol>

@property (strong, readonly) NSString           *itemId;
@property (strong, readonly) NSString           *name;
@property (assign, readonly) int         nrOfSubscribers;
@property (strong, readonly) NSArray            *subscribers;

@end
