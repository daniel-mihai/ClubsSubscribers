//
//  DMBaseViewController.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMStorageManager.h"

@interface DMBaseViewController : UIViewController
@property (nonatomic, strong) DMCoreDataStack *coreDataStack;

@end
