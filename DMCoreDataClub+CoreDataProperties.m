//
//  DMCoreDataClub+CoreDataProperties.m
//  
//
//  Created by Daniel Mihai on 13/03/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DMCoreDataClub+CoreDataProperties.h"
#import "DMSubscriber.h"
#import "DMClub.h"
#import "DMStorageManager.h"
#import "DMCoreDataSubscriber+CoreDataProperties.h"

@implementation DMCoreDataClub (CoreDataProperties)

@dynamic itemId;
@dynamic name;
@dynamic nrOfSubscribers;


+ (void)insertOrUpdateCoreDataObject:(id<CoreDataObjectWriterProtocol>)coreDataObject forEntityObject:(id<EntityModelProtocol>)object inContext:(NSManagedObjectContext *)managedObjectContext
{
    DMCoreDataClub *coreDataClub = nil;
    
    if (coreDataObject) {
        coreDataClub = (DMCoreDataClub *)coreDataObject;
    } else {
        coreDataClub = [NSEntityDescription insertNewObjectForEntityForName:[DMCoreDataClub entityName] inManagedObjectContext:managedObjectContext];
    }
    [self setPropertiesToCoreDataClub:coreDataClub fromClubObject:object inContext:managedObjectContext];
}


+ (void)setPropertiesToCoreDataClub:(DMCoreDataClub *)coreDataClub fromClubObject:(DMClub *)enumeratedClub inContext:(NSManagedObjectContext *)context
{
    coreDataClub.itemId             = enumeratedClub.itemId;
    coreDataClub.name               = enumeratedClub.name;
    coreDataClub.nrOfSubscribers    = enumeratedClub.nrOfSubscribers;
    
    for (DMSubscriber *aSubscriber in enumeratedClub.subscribers) {
        [DMCoreDataSubscriber insertOrUpdateCoreDataObject:nil forEntityObject:aSubscriber inContext:context];
    }
    
}
@end
