//
//  DMStorageManager.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataObjectWriterProtocol.h"
#import "DMCoreDataStack.h"


#define kDMStorageManager [DMStorageManager sharedStorageManager]

@interface DMStorageManager : NSObject

+ (instancetype)sharedStorageManager;
- (DMCoreDataStack *)getCurrentCoreDataStack;
- (void)initCoreDataStackForDbName:(NSString *)dbName withCompletionBlock:(CoreDataRWCompletionBlock)completionBlock;
- (void)addItemsToCoreData:(NSArray *)arrayOfItems itemType:(Class)itemType withCompletionBlock:(CoreDataRWCompletionBlock)completionBlock;
- (NSArray *)executeFetchRequestAndWait:(NSFetchRequest *)request inContext:(NSManagedObjectContext *)context;

@end


@interface NSManagedObject(EntityName)

+ (NSString*)entityName;

@end