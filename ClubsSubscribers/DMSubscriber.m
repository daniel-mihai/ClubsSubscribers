//
//  DMSubscriber.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "DMSubscriber.h"

#define ID_KEY                  @"_id"
#define NAME_KEY                @"name"
#define IS_ACTIVE_KEY           @"isActive"
#define EYE_COLOR_KEY           @"eyeColor"
#define GENDER_KEY              @"gender"
#define COMPANY_KEY             @"company"
#define EMAIL_KEY               @"email"
#define PHONE_KEY               @"phone"
#define ADDRESS_KEY             @"address"
#define ABOUT_KEY               @"about"
#define REGISTERED_KEY          @"registered"
#define TAGS_KEY                @"tags"
#define GREETING_KEY            @"greeting"
#define FAVORITE_FRUIT_KEY      @"favoriteFruit"
//additional core data keys
#define CLUB_ID_KEY             @"clubId"
#define ITEM_ID_KEY             @"itemId"

@implementation DMSubscriber


- (id)initWithDictionary:(NSDictionary *)dictionary foreignKey:(NSString *)foreignKey;
{
    self = [super init];
    
    if (self) {
        _itemId                 = (NSString *)[dictionary valueForKey:ID_KEY];
        _clubId                 = foreignKey;
        _name                   = (NSString *)[dictionary valueForKey:NAME_KEY];
        _isActive               = [[dictionary valueForKey:IS_ACTIVE_KEY] boolValue];
        _eyeColor               = (NSString *)[dictionary valueForKey:EYE_COLOR_KEY];
        _gender                 = (NSString *)[dictionary valueForKey:GENDER_KEY];
        _company                = (NSString *)[dictionary valueForKey:COMPANY_KEY];
        _email                  = (NSString *)[dictionary valueForKey:EMAIL_KEY];
        _phone                  = (NSString *)[dictionary valueForKey:PHONE_KEY];
        _address                = (NSString *)[dictionary valueForKey:ADDRESS_KEY];
        _about                  = (NSString *)[dictionary valueForKey:ABOUT_KEY];
        _registered             = (NSString *)[dictionary valueForKey:REGISTERED_KEY];
        _greeting               = (NSString *)[dictionary valueForKey:GREETING_KEY];
        _favoriteFruit          = (NSString *)[dictionary valueForKey:FAVORITE_FRUIT_KEY];
        NSArray *tagsArray      = (NSArray *)[dictionary valueForKey:TAGS_KEY];
        _tags                   = [tagsArray componentsJoinedByString:TAGS_SEPARATOR];
    }
    
    return self;
}

- (id)initWithCoreDataDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        _itemId                 = (NSString *)[dictionary valueForKey:ITEM_ID_KEY];
        _clubId                 = (NSString *)[dictionary valueForKey:CLUB_ID_KEY];
        _name                   = (NSString *)[dictionary valueForKey:NAME_KEY];
        _isActive               = [[dictionary valueForKey:IS_ACTIVE_KEY] boolValue];
        _eyeColor               = (NSString *)[dictionary valueForKey:EYE_COLOR_KEY];
        _gender                 = (NSString *)[dictionary valueForKey:GENDER_KEY];
        _company                = (NSString *)[dictionary valueForKey:COMPANY_KEY];
        _email                  = (NSString *)[dictionary valueForKey:EMAIL_KEY];
        _phone                  = (NSString *)[dictionary valueForKey:PHONE_KEY];
        _address                = (NSString *)[dictionary valueForKey:ADDRESS_KEY];
        _about                  = (NSString *)[dictionary valueForKey:ABOUT_KEY];
        _registered             = (NSString *)[dictionary valueForKey:REGISTERED_KEY];
        _greeting               = (NSString *)[dictionary valueForKey:GREETING_KEY];
        _favoriteFruit          = (NSString *)[dictionary valueForKey:FAVORITE_FRUIT_KEY];
        _tags                   = (NSString *)[dictionary valueForKey:TAGS_KEY];
    }
    
    return self;
}



@end
