//
//  DMCellDetailsObject.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 14/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DMCellDetailsObject;

@protocol CellDetailsObjectProtocol <NSObject>

- (void)configureWithObject:(DMCellDetailsObject *)cellDetailsObject;

@end

@interface DMCellDetailsObject : NSObject
@property (nonatomic, strong) NSString *titleKey;
@property (nonatomic, strong) NSString *valueKey;
@property (nonatomic, assign) CGFloat heightOfCell;
@property (nonatomic, assign) NSString *cellIdentifier;

@end
