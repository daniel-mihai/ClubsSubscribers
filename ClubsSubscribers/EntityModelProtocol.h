//
//  EntityModelProtocol.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EntityModelProtocol <NSObject>


- (id)initWithDictionary:(NSDictionary *)dictionary foreignKey:(NSString *)foreignKey;

@optional

- (id)initWithCoreDataDictionary:(NSDictionary *)dictionary;
+ (Class)modelClass;
- (Class)coreDataClass;

@end
