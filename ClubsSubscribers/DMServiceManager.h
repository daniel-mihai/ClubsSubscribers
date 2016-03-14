//
//  DMServiceManager.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#define kDMServiceManager [DMServiceManager sharedApiManager]

typedef void (^ResultCompletionBlock)(NSError *serviceCallError, id dataResult);
typedef void (^ServiceCallCompletionBlock)(NSError *serviceCallError, id dataResult, NSURLResponse *response);



@interface DMServiceManager : AFHTTPSessionManager
+ (instancetype)sharedApiManager;
- (void)getAllClubsWithCompletionBlock:(ServiceCallCompletionBlock)completionBlock;
- (void)downloadAndSaveAllClubsWithCompletionBlock:(ResultCompletionBlock)completionBlock;

@end
