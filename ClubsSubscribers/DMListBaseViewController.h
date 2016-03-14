//
//  DMListBaseViewController.h
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMBaseViewController.h"

@interface DMListBaseViewController : DMBaseViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;

- (NSString *)entityName;
- (void)reloadTableAndData;
- (NSArray *)sortDescriptors;
- (NSString *)cellIdentifier;
- (NSFetchedResultsController *)fetchedResultsControllerForTableView:(UITableView *)tableView;

@end
