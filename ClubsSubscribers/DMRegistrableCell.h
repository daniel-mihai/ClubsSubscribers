//
//  DMRegistrableCell.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DMRegistrableCell <NSObject>

+ (NSString *)cellIdentifier;
+ (NSString *)cellNibName;

@end
