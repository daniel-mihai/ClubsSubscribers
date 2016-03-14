//
//  DMCoreDataStack.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "DMCoreDataStack.h"
#import "GlobalConstants.h"
#import "Utils.h"

@interface DMCoreDataStack()
@property (nonatomic, strong) NSManagedObjectModel   *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContextBackgroundQueue;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContextMainQueue;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContextWorkerOnBackground;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator ;

@end


@implementation DMCoreDataStack


@synthesize managedObjectContextMainQueue = _managedObjectContextMainQueue;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectContextBackgroundQueue = _managedObjectContextBackgroundQueue;
@synthesize managedObjectContextWorkerOnBackground = _managedObjectContextWorkerOnBackground;


- (void)configureCoreDataStackForDDName:(NSString *)dbName withCompletionBlock:(CoreDataRWCompletionBlock)completionBlock
{
   
    
    if (!dbName) {
        NSError *error = [[NSError alloc] initWithDomain:@"No db name provided. Please provide a database name in order to save records" code:1 userInfo:nil];
        completionBlock(error, nil);
        return;
    }
    
    //model
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
   
    NSURL *storeURL = [DMCoreDataStack databaseUrl:dbName];
    NSError *error = nil;
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    
    
    NSPersistentStore *store  = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
    if (!store) {
        NSLog(@"Error adding persistent store to coordinator %@\n%@",
             [error localizedDescription], [error userInfo]);
        //Present a user facing error
    }
    
    
    //background context
    _managedObjectContextBackgroundQueue = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [_managedObjectContextBackgroundQueue setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
    //main context
    _managedObjectContextMainQueue = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContextMainQueue.parentContext = _managedObjectContextBackgroundQueue;
    
    //worker context, the new thing
    _managedObjectContextWorkerOnBackground = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    _managedObjectContextWorkerOnBackground.parentContext = _managedObjectContextMainQueue;
    
   
        if (completionBlock) {
            completionBlock(error, nil);
    }
}

+ (NSString *)applicationDatabaseDirectory
{
    NSString *appDirectory = [Utils getCurrentDirectory];
    
    NSString *databaseDirectory = [appDirectory stringByAppendingPathComponent:AppDatabaseFolderName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:databaseDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:databaseDirectory withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
    }
    
    return databaseDirectory;
}

+ (NSURL *)databaseUrl:(NSString *)dbName
{
    NSString *databaseKey = dbName;
    
    NSURL *storeUrl = [NSURL fileURLWithPath: [[DMCoreDataStack applicationDatabaseDirectory]
                                               stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.sqlite", databaseKey]]];
    return storeUrl;
}


@end
