//
//  DMStorageManager.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "DMStorageManager.h"
#import <CoreData/CoreData.h>
#import "GlobalConstants.h"
#import "EntityModelProtocol.h"

@interface DMStorageManager()
@property (strong, nonatomic) DMCoreDataStack *coreDataStack;

@end

@implementation DMStorageManager


+ (instancetype)sharedStorageManager
{
    static DMStorageManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[DMStorageManager alloc] init];
    });
    
    return _sharedManager;
}

- (DMCoreDataStack *)getCurrentCoreDataStack
{
    return _coreDataStack;
}

- (void)initCoreDataStackForDbName:(NSString *)dbName withCompletionBlock:(CoreDataRWCompletionBlock)completionBlock
{
    DMCoreDataStack *newStack = [[DMCoreDataStack alloc] init];
    [newStack configureCoreDataStackForDDName:dbName withCompletionBlock:^(NSError *error, id dataResult) {
        
        _coreDataStack = newStack;

        if (completionBlock) {
            completionBlock(error, newStack);
        }
    }];
}


- (void)addItemsToCoreData:(NSArray *)arrayOfItems itemType:(Class)itemType withCompletionBlock:(CoreDataRWCompletionBlock)completionBlock
{
    
    DMCoreDataStack *existingStack                 = [self getCurrentCoreDataStack];
    NSManagedObjectContext *managedObjectContextWorker = [existingStack managedObjectContextWorkerOnBackground];
    
    if (!managedObjectContextWorker ) {
        NSError *error = [[NSError alloc] initWithDomain:@"No worker context, please review core data stack logic" code:1 userInfo:nil];
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(error, nil);
            });
        }
        return;
    }
    
    [managedObjectContextWorker performBlock:^{
        
        
        [arrayOfItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            
            [itemType insertOrUpdateCoreDataObject:nil forEntityObject:(id<EntityModelProtocol>)obj inContext:managedObjectContextWorker];
        }];
        
        
        //save changes
        [self saveContextForCoreDataStack:existingStack shouldWaitToCommit:NO];
        
        NSError *saveError = nil;
        
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(saveError, nil);
            });
        }
        
    } ];
    
}


- (NSArray *)executeFetchRequestAndWait:(NSFetchRequest *)request inContext:(NSManagedObjectContext *)context
{
    if (![NSThread isMainThread]) {
        [NSException raise:@"Please call this from main thread only" format:@"And announce where was the exception, because it may be the source of a freeze"];
    }
    
    if (!context) {
        return [NSArray array];
    }
    if (!request) {
        return [NSArray array];
    }
    
    if (request.entityName == nil) {
        [NSException raise:@"Entity is nil" format:@"Will crash the app"];
        return [NSArray array];
        
    }
    
    __block NSArray *results = nil;
    [context performBlockAndWait:^{
        
        NSError *error = nil;
        
        results = [context executeFetchRequest:request error:&error];
        
        if (error)
        {
            NSLog(@"Something here to handle the errors");
        }
        
    }];
    
    return results;
}


- (void)saveContextForCoreDataStack:(DMCoreDataStack*)aStack shouldWaitToCommit:(BOOL)shouldWait
{
    NSManagedObjectContext *mocMain = [aStack managedObjectContextMainQueue];
    NSManagedObjectContext *private = [aStack managedObjectContextBackgroundQueue];
    NSManagedObjectContext *privateWorker = [aStack managedObjectContextWorkerOnBackground];
    
    if (!privateWorker) return;
    if ([privateWorker hasChanges]) {
        [privateWorker performBlockAndWait:^{
            NSError *error = nil;
            [privateWorker save:&error];
        }];
    }
    
    
    if (!mocMain) return;
    if ([mocMain hasChanges]) {
        [mocMain performBlockAndWait:^{
            NSError *error = nil;
            [mocMain save:&error];
        }];
    }
    
    void (^savePrivate) (void) = ^{
        NSError *error2 = nil;
        [private save:&error2];
    };
    if ([private hasChanges]) {
        if (shouldWait) {
            [private performBlockAndWait:savePrivate];
        } else {
            [private performBlock:savePrivate];
        }
    }
}
@end

@implementation NSManagedObject(EntityName)

+ (NSString *)entityName
{
    return NSStringFromClass([self class]);
}


@end
