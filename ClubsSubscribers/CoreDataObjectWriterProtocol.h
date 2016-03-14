//
//  CoreDataObjectWriterProtocol.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityModelProtocol.h"
#import <CoreData/CoreData.h>


@protocol CoreDataObjectWriterProtocol <NSObject>

+ (void)insertOrUpdateCoreDataObject:(id<CoreDataObjectWriterProtocol>)coreDataObject forEntityObject:(id<EntityModelProtocol>)object inContext:(NSManagedObjectContext *)managedObjectContext;

@optional
+ (NSString *)comparisonPropertyName;
+ (NSPredicate *)comparisonPredicateForObject:(id<EntityModelProtocol>)entityModel;

@end
