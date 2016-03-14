//
//  Utils.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (void)handleError:(NSError *)error withTile:(NSString *)title andMessage:(NSString *)message displayAlert:(BOOL)displayAlert;
+ (NSArray *)initItemsArray:(NSArray *)itemsData ofType:(Class)modelClass foreignKey:(NSString *)foreignKey;
+ (NSString*)getCurrentDirectory;
+ (NSString *)generateUniqueStringForFetchedResultControllerCache;

@end
