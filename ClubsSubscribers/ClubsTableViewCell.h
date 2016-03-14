//
//  ClubsTableViewCell.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMRegistrableCell.h"

@interface ClubsTableViewCell : UITableViewCell<DMRegistrableCell>

- (void) configureWithName:(NSString *)name subscribers:(int)subscribers;

@end
