//
//  SubscribersTableViewCell.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMRegistrableCell.h"
#import "DMCellDetailsObject.h"

@interface SubscribersTableViewCell : UITableViewCell<DMRegistrableCell, CellDetailsObjectProtocol>

- (void) configureWithName:(NSString *)name isActive:(BOOL)isActive;


@end
