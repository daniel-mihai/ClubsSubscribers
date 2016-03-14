//
//  TitleTextTableViewCell.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMRegistrableCell.h"
#import "DMCellDetailsObject.h"

@interface TitleTextTableViewCell : UITableViewCell<DMRegistrableCell, CellDetailsObjectProtocol>

- (void)configureWithTitle:(NSString *)title andText:(NSString *)text;

@end
