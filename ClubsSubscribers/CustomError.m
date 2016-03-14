//
//  CustomError.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "CustomError.h"

#define ERROR_DOMAIN_SOMETHING @"ceva de vis"
#define ERROR_CODE_DEFAULT 1

@implementation CustomError


- (instancetype)initWithDescription:(NSString *)description
{
    NSDictionary *errorDictionary = @{ NSLocalizedDescriptionKey : NSLocalizedString(description, @"")};
    self = [super initWithDomain:ERROR_DOMAIN_SOMETHING code:ERROR_CODE_DEFAULT userInfo:errorDictionary];
    return self;
}

@end
