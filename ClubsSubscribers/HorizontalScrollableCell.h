//
//  HorizontalScrollableCell.h
//  Events 3.0
//
//  Created by Daniel on 20/11/15.
//  Copyright © 2015 World Economic Forum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMRegistrableCell.h"
#import "DMCellDetailsObject.h"

//!!will not use auto layout
@interface HorizontalScrollableCell : UITableViewCell<DMRegistrableCell, CellDetailsObjectProtocol>

@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;

- (void)configureWithObject:(DMCellDetailsObject *)cellDetailsObject;

@end
