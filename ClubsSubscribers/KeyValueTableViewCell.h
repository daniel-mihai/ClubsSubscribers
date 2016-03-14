//
//  KeyValueTableViewCell.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMRegistrableCell.h"
#import "DMCellDetailsObject.h"

@interface KeyValueTableViewCell : UITableViewCell<DMRegistrableCell, CellDetailsObjectProtocol>
- (void) configureWithKey:(NSString *)key andValue:(NSString *)value;

@end
