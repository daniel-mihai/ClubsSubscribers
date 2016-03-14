//
//  DMCoreDataClub+CoreDataProperties.h
//  
//
//  Created by Daniel Mihai on 13/03/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DMCoreDataClub.h"
#import "CoreDataObjectWriterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DMCoreDataClub (CoreDataProperties)<CoreDataObjectWriterProtocol>

@property (nullable, nonatomic, retain) NSString *itemId;
@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) int32_t nrOfSubscribers;

@end

NS_ASSUME_NONNULL_END
