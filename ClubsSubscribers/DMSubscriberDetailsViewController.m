//
//  DMSubscriberDetailsViewController.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "DMSubscriberDetailsViewController.h"
#import "SubscribersTableViewCell.h"
#import "TitleTextTableViewCell.h"
#import "KeyValueTableViewCell.h"
#import "DMStorageManager.h"
#import "DMSubscriber.h"
#import "DMCoreDataSubscriber+CoreDataProperties.h"
#import "DMCellDetailsObject.h"
#import "HorizontalScrollableCell.h"
#import "Utils.h"

#define DEFAULT_CELL_HEIGHT 44
#define TO_BE_CALCULATED_HEIGHT 0

@interface DMSubscriberDetailsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DMSubscriber *currentSubscriber;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation DMSubscriberDetailsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self registerTheNibs];
}

- (void)registerTheNibs
{
    //register the nibs
    UINib *messageNib = [UINib nibWithNibName:[SubscribersTableViewCell cellNibName] bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:messageNib forCellReuseIdentifier:[SubscribersTableViewCell cellIdentifier]];
    
    UINib *messageNib2 = [UINib nibWithNibName:[KeyValueTableViewCell cellNibName] bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:messageNib2 forCellReuseIdentifier:[KeyValueTableViewCell cellIdentifier]];
    
    UINib *messageNib3 = [UINib nibWithNibName:[TitleTextTableViewCell cellNibName] bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:messageNib3 forCellReuseIdentifier:[TitleTextTableViewCell cellIdentifier]];
    
    UINib *messageNib4 = [UINib nibWithNibName:[HorizontalScrollableCell cellNibName] bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:messageNib4 forCellReuseIdentifier:[HorizontalScrollableCell cellIdentifier]];
}


- (void) initDataSource
{
    NSFetchRequest *aRequest = [NSFetchRequest fetchRequestWithEntityName:[DMCoreDataSubscriber entityName]];
    [aRequest setPredicate:[NSPredicate predicateWithFormat:@"itemId = %@", self.subscriberId]];
    [aRequest setResultType:NSDictionaryResultType];
    NSDictionary *objectAsDic = [[kDMStorageManager executeFetchRequestAndWait:aRequest inContext:self.coreDataStack.managedObjectContextMainQueue] firstObject];
    
    if (objectAsDic) {
        self.currentSubscriber = [[DMSubscriber alloc] initWithCoreDataDictionary:objectAsDic];
        self.dataSourceArray = [[NSMutableArray alloc] init];
        //add the rows
        [self addToDataSourceObjectWithKey:_currentSubscriber.name value:[NSString stringWithFormat:@"%d", _currentSubscriber.isActive] cellIdentifier:[SubscribersTableViewCell cellIdentifier] height:DEFAULT_CELL_HEIGHT];
        [self addToDataSourceObjectWithKey:@"Gender :" value:_currentSubscriber.gender cellIdentifier:[KeyValueTableViewCell cellIdentifier] height:DEFAULT_CELL_HEIGHT];
        [self addToDataSourceObjectWithKey:@"Age :" value:[NSString stringWithFormat:@"%d", _currentSubscriber.age] cellIdentifier:[KeyValueTableViewCell cellIdentifier] height:DEFAULT_CELL_HEIGHT];
        [self addToDataSourceObjectWithKey:@"Eye color :" value:_currentSubscriber.eyeColor cellIdentifier:[KeyValueTableViewCell cellIdentifier] height:DEFAULT_CELL_HEIGHT];
        [self addToDataSourceObjectWithKey:@"Company :" value:_currentSubscriber.company cellIdentifier:[KeyValueTableViewCell cellIdentifier] height:DEFAULT_CELL_HEIGHT];
        [self addToDataSourceObjectWithKey:@"Email :" value:_currentSubscriber.email cellIdentifier:[KeyValueTableViewCell cellIdentifier] height:DEFAULT_CELL_HEIGHT];
        [self addToDataSourceObjectWithKey:@"Phone :" value:_currentSubscriber.phone cellIdentifier:[KeyValueTableViewCell cellIdentifier] height:DEFAULT_CELL_HEIGHT];
        [self addToDataSourceObjectWithKey:@"Registered :" value:_currentSubscriber.registered cellIdentifier:[KeyValueTableViewCell cellIdentifier] height:DEFAULT_CELL_HEIGHT];
        [self addToDataSourceObjectWithKey:@"Address :" value:_currentSubscriber.address cellIdentifier:[TitleTextTableViewCell cellIdentifier] height:TO_BE_CALCULATED_HEIGHT];
        
        [self addToDataSourceObjectWithKey:_currentSubscriber.tags value:nil cellIdentifier:[HorizontalScrollableCell cellIdentifier] height:DEFAULT_CELL_HEIGHT];
        
        [self addToDataSourceObjectWithKey:@"Greeting :" value:_currentSubscriber.greeting cellIdentifier:[TitleTextTableViewCell cellIdentifier] height:TO_BE_CALCULATED_HEIGHT];
        
    }
}

- (void)addToDataSourceObjectWithKey:(NSString *)key value:(NSString *)value cellIdentifier:(NSString *)cellIdentifier height:(CGFloat) height
{
    DMCellDetailsObject *anObject = [[DMCellDetailsObject alloc] init];
    anObject.titleKey = key;
    anObject.valueKey = value;
    anObject.cellIdentifier = cellIdentifier;
    anObject.heightOfCell = height;
    [self.dataSourceArray addObject:anObject];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataSourceArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    DMCellDetailsObject *anObject = [self.dataSourceArray objectAtIndex:indexPath.row];
    if (anObject.heightOfCell == TO_BE_CALCULATED_HEIGHT) {
        static TitleTextTableViewCell *sizingCell = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sizingCell = [tableView dequeueReusableCellWithIdentifier:[TitleTextTableViewCell cellIdentifier]];
        });
        
        [sizingCell configureWithObject:anObject];
        return [self calculateHeightForConfiguredSizingCell:sizingCell inTableView:self.tableView];
        
    }else{
        return anObject.heightOfCell;

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMCellDetailsObject *anObject = [self.dataSourceArray objectAtIndex:indexPath.row];
    UITableViewCell<CellDetailsObjectProtocol> *aCell = [self.tableView dequeueReusableCellWithIdentifier:anObject.cellIdentifier];
    [aCell configureWithObject:anObject];
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
    aCell.accessoryType = UITableViewCellAccessoryNone;

    return aCell;
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell inTableView:(UITableView *)tableView {
    
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //    NSLog(@"calculateHeightForConfiguredSizingCell for cell %@ and result %f", sizingCell, size.height);
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.tableView reloadData];
}


@end
