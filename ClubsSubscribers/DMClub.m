//
//  DMClub.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "DMClub.h"
#import "DMSubscriber.h"
#import "Utils.h"
#import "DMStorageManager.h"
#import "DMSubscriber.h"


#define ID_KEY @"_id"
#define NAME_KEY @"name"
#define SUBSCRIBERS_KEY @"subscribers"


@implementation DMClub
- (id)initWithDictionary:(NSDictionary *)dictionary foreignKey:(NSString *)foreignKey;
{
    self = [super init];
    
    if (self) {
        _itemId = (NSString *)[dictionary valueForKey:ID_KEY];
        _name = (NSString *)[dictionary valueForKey:NAME_KEY];
        _subscribers  = [Utils initItemsArray:[dictionary valueForKey:SUBSCRIBERS_KEY] ofType:[DMSubscriber class] foreignKey:_itemId];
        _nrOfSubscribers = (int)[_subscribers count];
    }
    
    return self;
}

@end
