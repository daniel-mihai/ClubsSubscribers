//
//  DMServiceManager.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "DMServiceManager.h"
#import "GlobalConstants.h"
#import "Utils.h"
#import "CustomError.h"
#import "DMClub.h"
#import "DMSubscriber.h"
#import "DMStorageManager.h"
#import "DMCoreDataSubscriber+CoreDataProperties.h"
#import "DMCoreDataClub+CoreDataProperties.h"


@implementation DMServiceManager

#define REQ_DEFAULT_TIMEOUT_INTERVAL 30


+ (instancetype)sharedApiManager
{
    static DMServiceManager *_sharedApiManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *baseURl = ApiBaseUrl;
        
        _sharedApiManager = [[DMServiceManager alloc] initWithBaseURL:[NSURL URLWithString:baseURl]];
        _sharedApiManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedApiManager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
        
        [[_sharedApiManager requestSerializer] setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [[_sharedApiManager requestSerializer] setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
        _sharedApiManager.responseSerializer.acceptableContentTypes = nil;
    });
    
    return _sharedApiManager;
}

- (void)downloadAndSaveAllClubsWithCompletionBlock:(ResultCompletionBlock)completionBlock
{
    [kDMServiceManager getAllClubsWithCompletionBlock:^(NSError *serviceCallError, id dataResult, NSURLResponse *response) {
        if (!serviceCallError) {
            [kDMStorageManager addItemsToCoreData:dataResult itemType:[DMCoreDataClub class] withCompletionBlock:^(NSError *error, id dataResult) {
                
                if (completionBlock) {
                    completionBlock (error, nil);
                }
            }];
        }else {
            if (completionBlock) {
                completionBlock(serviceCallError, nil);
            }
        }
    }];
}



- (void)getAllClubsWithCompletionBlock:(ServiceCallCompletionBlock)completionBlock
{
    NSString *serviceName = ClubsRelUrl;
    [self GET:serviceName parameters:nil returnTypeClass:[DMClub class] completionBlock:completionBlock];
}



- (void)GET:(NSString *)URLString parameters:(id)parameters returnTypeClass:(Class)returnTypeClass completionBlock:(ServiceCallCompletionBlock)completionBlock
{
    [self requestForService:URLString withMethod:@"GET" parameters:parameters returnTypeClass:returnTypeClass timeout:REQ_DEFAULT_TIMEOUT_INTERVAL withErorResponseObjectType:nil completionBlock:completionBlock];
}


- (void)requestForService:(NSString *)URLString withMethod:(NSString *)HTTPMethod parameters:(NSDictionary *)parameters returnTypeClass:(Class)returnTypeClass timeout:(NSTimeInterval)timeout withErorResponseObjectType:(Class)errorResponseObjectTypeClass completionBlock:(ServiceCallCompletionBlock)completionBlock
{
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:HTTPMethod URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        
        if (error) {
            NSError *returnError = error;
            
            NSString *errorTitle = [NSString stringWithFormat:@"An error occured when calling service:%@.", URLString];

            
            if ([[error domain] isEqualToString:NSURLErrorDomain]){
                switch ([error code]) {
                    case NSURLErrorNotConnectedToInternet:
                        
                        errorTitle = @"No internet connection";
                        break;
                    default:
                        break;
                }
            }
            
            
            
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
                userInfo[kErrorResponseObjectKey] = response;
                
                
                returnError = [NSError errorWithDomain:error.domain
                                                  code:error.code
                                              userInfo:[userInfo copy]];
            }
            
            
            [Utils handleError:returnError withTile:errorTitle andMessage:@"We'll use the local file instead" displayAlert:YES];
            
            
            NSArray * localContentJson = [kDMServiceManager getJsonDicFromFileName:LocalFileName ofType:LocalFileExtension];
            if (localContentJson) {
                
                if (completionBlock) {
                    
                    if (!returnTypeClass) {
                        NSLog(@"returnTypeClass should not be nil");
                    }
                    completionBlock(nil, [Utils initItemsArray:localContentJson ofType:returnTypeClass foreignKey:nil], response);
                    
                    
                }
            }else if (completionBlock)
            {
                completionBlock(returnError, nil, response);
            }
            
            
        } else {
            if (!returnTypeClass) {//pass the string forward as is
                
                if (completionBlock) {
                    completionBlock(nil, responseObject, response);
                }
            } else if ([responseObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                if (completionBlock) {
                    completionBlock(nil, [[returnTypeClass alloc] initWithDictionary:responseDictionary], response);
                }
            } else if ([responseObject isKindOfClass:[NSArray class]]) {
                NSArray *serviceResultArray = (NSArray *)responseObject;
                if (completionBlock) {
                    if (!returnTypeClass) {
                        NSLog(@"returnTypeClass should not be nil");
                    }
                    completionBlock(nil, [Utils initItemsArray:serviceResultArray ofType:returnTypeClass foreignKey:nil], response);
                }
            }  else {
                NSString *errorDescription = [NSString stringWithFormat:@"An error occured when calling service:%@, Error: Unexpected response type, json was just bad %@", URLString, responseObject];
                
                CustomError *customError = [[CustomError alloc] initWithDescription:errorDescription];
                if (completionBlock) {
                    completionBlock(customError, nil, response);
                }
            }
        }
    }];
    
    [task resume];
}


- (NSArray *)getJsonDicFromFileName:(NSString *)fileName ofType:(NSString *)fileExtension
{
    NSError *error ;
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExtension ];
    NSString* stringContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    
    NSError *jsonError;
    NSData *objectData = [stringContent dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&jsonError];
    
    if (error || jsonError) {
        return nil;
    }
    
    return json;
     
}


@end
