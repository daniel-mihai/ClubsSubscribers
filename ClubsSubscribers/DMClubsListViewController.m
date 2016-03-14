//
//  DMClubsListViewController.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "DMClubsListViewController.h"
#import "DMServiceManager.h"
#import "DMClub.h"
#import "DMStorageManager.h"
#import "GlobalConstants.h"
#import "DMCoreDataClub+CoreDataProperties.h"
#import "ClubsTableViewCell.h"
#import "DMSubscribersListViewController.h"

@interface DMClubsListViewController ()

@end

@implementation DMClubsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Clubs";

    //register the nibs
    UINib *messageNib = [UINib nibWithNibName:[ClubsTableViewCell cellNibName] bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:messageNib forCellReuseIdentifier:[ClubsTableViewCell cellIdentifier]];
    
}


- (NSString *)entityName
{
    return [DMCoreDataClub entityName];
    
}

- (NSString *)cellIdentifier
{
    return [ClubsTableViewCell cellIdentifier];
}

- (NSArray *)sortDescriptors
{
    NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [NSArray arrayWithObjects:nameDescriptor, nil];
}

- (void)fetchedResultController:(NSFetchedResultsController*)fetchController configureCell:(UITableViewCell*)theCell atIndexPath:(NSIndexPath*)theIndexPath inController:(DMListBaseViewController *)theController{
    
    if ([theCell isKindOfClass:[ClubsTableViewCell class]]) {
        ClubsTableViewCell *cell = (ClubsTableViewCell *)theCell;
        
        DMCoreDataClub *club = (DMCoreDataClub *)[fetchController objectAtIndexPath:theIndexPath];
        [cell configureWithName:club.name subscribers:club.nrOfSubscribers];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSFetchedResultsController *fetchController = [self fetchedResultsControllerForTableView:tableView];
    DMCoreDataClub *club = (DMCoreDataClub *)[fetchController objectAtIndexPath:indexPath];
    DMSubscribersListViewController *subs = [[UIStoryboard storyboardWithName:StoryboardName bundle:nil] instantiateViewControllerWithIdentifier:@"DMSubscribersListViewControllerStoryboardId"];
    subs.clubId = club.itemId;
    [self.navigationController pushViewController:subs animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
