//
//  Utils.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "Utils.h"
#import <UIKit/UIKit.h>
#import "EntityModelProtocol.h"
#import "GlobalConstants.h"


@implementation Utils


+ (void)handleError:(NSError *)error withTile:(NSString *)title andMessage:(NSString *)message displayAlert:(BOOL)displayAlert
{
    NSString *errorMsg = message;
    if ([[error domain] isEqualToString:NSURLErrorDomain]){
        switch ([error code]) {
            case NSURLErrorNotConnectedToInternet:
                errorMsg = NSLocalizedString(@"Cannot connect to the internet. Service may not be available.", nil);
                break;
            default:
                break;
        }
    }
    
    
    if (displayAlert) {
        [Utils displayAlertViewWithMessage:errorMsg andTitle:title];
    }
}

+ (void)displayAlertViewWithMessage:(NSString*)message andTitle:(NSString*)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}


+ (NSArray *)initItemsArray:(NSArray *)itemsData ofType:(Class)modelClass foreignKey:(NSString *)foreignKey
{
    
    NSMutableArray *itemsArray = [NSMutableArray array];
    //    NSLog(@"initItemsArray %@ ofType %@", itemsData, modelClass);
    if (itemsData && [itemsData isKindOfClass:[NSArray class]]) {
        [itemsData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (obj) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    if (modelClass == nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils displayAlertViewWithMessage:@"Bad call in this function" andTitle:@"Please call it properly"];
                        });
                    }else
                    {
                        id modelEntityInstance = [[modelClass alloc] initWithDictionary:obj foreignKey:foreignKey];
                        [itemsArray addObject:modelEntityInstance];
                    }
                } else if ([obj isKindOfClass:[NSString class]]) {
                    [itemsArray addObject:obj];
                }
            }
        }];
    }
    
    return itemsArray;
}


+ (NSString*)getCurrentDirectory
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *appDirectory       = [documentsDirectory stringByAppendingPathComponent:AppDataDir];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:appDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:appDirectory withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
    }
    
    BOOL willSkipBackup =  [Utils addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:appDirectory isDirectory:YES]];
    if (!willSkipBackup) {
        NSLog(@"Cannot skip backup in cloud. Won't happen");
    }
    return appDirectory;
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}


+ (NSString *)generateUniqueStringForFetchedResultControllerCache
{
    NSString *UUID = [[NSUUID UUID] UUIDString];
    return UUID;
}



@end
