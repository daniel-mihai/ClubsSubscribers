//
//  DMCoreDataStack.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void (^CoreDataRWCompletionBlock)(NSError *error, id dataResult);


@interface DMCoreDataStack : NSObject
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContextBackgroundQueue;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContextMainQueue;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContextWorkerOnBackground;
- (void)configureCoreDataStackForDDName:(NSString *)dbName withCompletionBlock:(CoreDataRWCompletionBlock)completionBlock;

@end
