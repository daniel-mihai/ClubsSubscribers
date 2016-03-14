//
//  CustomError.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomError : NSError


- (instancetype)initWithDescription:(NSString *)description;

@end
