//
//  DMListBaseViewController.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "DMListBaseViewController.h"
#import "Utils.h"
#import "DMStorageManager.h"
#import "DMServiceManager.h"
#import "GlobalConstants.h"

#define BATCH_SIZE_FOR_FETCHED_RESULT_CONTROLLER 30


@interface DMListBaseViewController ()<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController    *fetchedResultsController;


@end

@implementation DMListBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (NSString *)entityName
{
    [NSException raise:@"Please implement in subclasses " format:@"implement entity name for class %@", NSStringFromClass([self class])];
    return nil;
}

- (NSString *)cellIdentifier
{
    //since it's only a type of cells, we'll use cell identifier here
    
    [NSException raise:@"Please implement in subclasses " format:@"implement cell identifier for class %@", NSStringFromClass([self class])];
    return nil;
}



- (NSArray *)sortDescriptors
{
    [NSException raise:@"Please implement in subclasses " format:@"implement sort descriptors for class %@", NSStringFromClass([self class])];
    
    return nil;
}

- (NSString *)sectionNameKeyPath
{
    //you may want to implement this in subclasses. Will return a plain list for now
    return nil;
}

- (NSPredicate *)fetchPredicate
{
    return [NSPredicate predicateWithValue:YES]; //overwrite if needed
}


- (void)reloadTableAndData
{
    self.fetchedResultsController = [self newFetchedResultsController];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark FetchController creation

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController)
        return _fetchedResultsController;
    
    self.fetchedResultsController = [self newFetchedResultsController];
    
    return _fetchedResultsController;
    
}


- (NSFetchedResultsController *)newFetchedResultsController
{
    
    if (!self.coreDataStack || ![self.coreDataStack managedObjectContextMainQueue]) {
        NSLog(@"Unable to create a new instance for frc: coreDataStack or managedObjectContextMainQueue is nil");
        return nil;
    }
    
    if (!self.entityName) {
        NSLog(@"Unable to create a new instance for frc: entity name is nil");
        return nil;
    }
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    [fetchRequest setFetchBatchSize:BATCH_SIZE_FOR_FETCHED_RESULT_CONTROLLER];
    
    fetchRequest.predicate =  [self fetchPredicate];
    
    if (self.sortDescriptors) {
        [fetchRequest setSortDescriptors:self.sortDescriptors];
    }
    
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                          managedObjectContext:[self.coreDataStack managedObjectContextMainQueue]
                                                                            sectionNameKeyPath:[self sectionNameKeyPath] ?:nil
                                                                                     cacheName:[Utils generateUniqueStringForFetchedResultControllerCache]];
    
    frc.delegate = self;
    
    NSError *error = nil;
    [frc performFetch:&error];
    
    return frc;
}


#pragma mark -
#pragma mark FetchControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    UITableView *tableView = [self tableViewForFetchedResultController:controller];
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                     withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                     withRowAnimation:UITableViewRowAnimationFade];
            break;
        default: break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = [self tableViewForFetchedResultController:controller];
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self fetchedResultController:controller configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath inController:self];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)fetchedResultController:(NSFetchedResultsController*)fetchController configureCell:(UITableViewCell*)theCell atIndexPath:(NSIndexPath*)theIndexPath inController:(DMListBaseViewController *)theController{
    [NSException raise:@"Please implement in subclasses " format:@"implement configure cell for class %@", NSStringFromClass([self class])];

}



- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    UITableView *tableView = [self tableViewForFetchedResultController:controller];
    
    
    [tableView endUpdates];
}

- (UITableView *)tableViewForFetchedResultController:(NSFetchedResultsController *)fetchedResultsController
{
    return self.tableView;
}
- (NSFetchedResultsController *)fetchedResultsControllerForTableView:(UITableView *)tableView
{
    return self.fetchedResultsController;
}


#pragma mark - 
#pragma mark Tableview Datasource and some delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[self fetchedResultsControllerForTableView:tableView] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = [[self fetchedResultsControllerForTableView:tableView] sections];
    id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 44;//default height
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSFetchedResultsController *fetchController = [self fetchedResultsControllerForTableView:tableView];
    NSString *cellId =[self cellIdentifier];
    UITableViewCell *   cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    [self fetchedResultController:fetchController configureCell:cell atIndexPath:indexPath inController:self];
    
    return cell;
}


@end
