//
//  DMSubscribersListViewController.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "DMSubscribersListViewController.h"
#import "SubscribersTableViewCell.h"
#import "DMCoreDataSubscriber+CoreDataProperties.h"
#import "DMSubscriberDetailsViewController.h"
#import "GlobalConstants.h"

@interface DMSubscribersListViewController ()

@end

@implementation DMSubscribersListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //register the nibs
    UINib *messageNib = [UINib nibWithNibName:[SubscribersTableViewCell cellNibName] bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:messageNib forCellReuseIdentifier:[SubscribersTableViewCell cellIdentifier]];
    
}


- (NSString *)entityName
{
    return [DMCoreDataSubscriber entityName];
    
}
- (NSPredicate *)fetchPredicate
{
    return [NSPredicate predicateWithFormat:@"clubId=%@", _clubId];
}

- (NSString *)cellIdentifier
{
    return [SubscribersTableViewCell cellIdentifier];
}

- (NSArray *)sortDescriptors
{
    NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [NSArray arrayWithObjects:nameDescriptor, nil];
}

- (void)fetchedResultController:(NSFetchedResultsController*)fetchController configureCell:(UITableViewCell*)theCell atIndexPath:(NSIndexPath*)theIndexPath inController:(DMListBaseViewController *)theController{
    
    if ([theCell isKindOfClass:[SubscribersTableViewCell class]]) {
        SubscribersTableViewCell *cell = (SubscribersTableViewCell *)theCell;
        
        DMCoreDataSubscriber *club = (DMCoreDataSubscriber *)[fetchController objectAtIndexPath:theIndexPath];
        [cell configureWithName:club.name isActive:club.isActive];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSFetchedResultsController *fetchController = [self fetchedResultsControllerForTableView:tableView];
    DMCoreDataSubscriber *club = (DMCoreDataSubscriber *)[fetchController objectAtIndexPath:indexPath];
    DMSubscriberDetailsViewController *subs = [[UIStoryboard storyboardWithName:StoryboardName bundle:nil] instantiateViewControllerWithIdentifier:@"DMSubscriberDetailsViewControllerStoryboardId"];
    subs.subscriberId = club.itemId;
    [self.navigationController pushViewController:subs animated:YES];
}

@end
