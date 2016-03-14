//
//  DMCoreDataSubscriber+CoreDataProperties.m
//  
//
//  Created by Daniel Mihai on 13/03/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DMCoreDataSubscriber+CoreDataProperties.h"
#import "DMSubscriber.h"
#import "DMStorageManager.h"

@implementation DMCoreDataSubscriber (CoreDataProperties)

@dynamic itemId;
@dynamic name;
@dynamic clubId;
@dynamic eyeColor;
@dynamic age;
@dynamic isActive;
@dynamic gender;
@dynamic company;
@dynamic email;
@dynamic phone;
@dynamic address;
@dynamic about;
@dynamic registered;
@dynamic tags;
@dynamic greeting;
@dynamic favoriteFruit;


+ (void)insertOrUpdateCoreDataObject:(id<CoreDataObjectWriterProtocol>)coreDataObject forEntityObject:(id<EntityModelProtocol>)object inContext:(NSManagedObjectContext *)managedObjectContext
{
    DMCoreDataSubscriber *coreDataParticipant = nil;
    
    if (coreDataObject) {
        coreDataParticipant = (DMCoreDataSubscriber *)coreDataObject;
    } else {
        coreDataParticipant = [NSEntityDescription insertNewObjectForEntityForName:[DMCoreDataSubscriber entityName] inManagedObjectContext:managedObjectContext];
    }
    [self setPropertiesToCoreDataSubscriber:coreDataParticipant fromSubscriberObject:object];
    
}


+ (void)setPropertiesToCoreDataSubscriber:(DMCoreDataSubscriber *)coreDataSubscriber fromSubscriberObject:(DMSubscriber *)enumeratedSubscriber
{
    coreDataSubscriber.itemId       = enumeratedSubscriber.itemId;
    coreDataSubscriber.name         = enumeratedSubscriber.name;
    coreDataSubscriber.clubId       = enumeratedSubscriber.clubId;
    coreDataSubscriber.eyeColor     = enumeratedSubscriber.eyeColor;
    coreDataSubscriber.age          = enumeratedSubscriber.age;
    coreDataSubscriber.isActive     = enumeratedSubscriber.isActive;
    coreDataSubscriber.gender       = enumeratedSubscriber.gender;
    coreDataSubscriber.company      = enumeratedSubscriber.company;
    coreDataSubscriber.email        = enumeratedSubscriber.email;
    coreDataSubscriber.phone        = enumeratedSubscriber.phone;
    coreDataSubscriber.address      = enumeratedSubscriber.address;
    coreDataSubscriber.about        = enumeratedSubscriber.about;
    coreDataSubscriber.registered   = enumeratedSubscriber.registered;
    coreDataSubscriber.tags         = enumeratedSubscriber.tags;
    coreDataSubscriber.greeting     = enumeratedSubscriber.greeting;
    coreDataSubscriber.favoriteFruit = enumeratedSubscriber.favoriteFruit;
}


@end
