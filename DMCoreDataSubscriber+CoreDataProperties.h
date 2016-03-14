//
//  DMCoreDataSubscriber+CoreDataProperties.h
//  
//
//  Created by Daniel Mihai on 13/03/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DMCoreDataSubscriber.h"
#import "CoreDataObjectWriterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DMCoreDataSubscriber (CoreDataProperties)<CoreDataObjectWriterProtocol>

@property (nullable, nonatomic, retain) NSString *itemId;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *clubId;
@property (nullable, nonatomic, retain) NSString *eyeColor;
@property (nonatomic) int32_t age;
@property (nonatomic) BOOL isActive;
@property (nullable, nonatomic, retain) NSString *gender;
@property (nullable, nonatomic, retain) NSString *company;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *about;
@property (nullable, nonatomic, retain) NSString *registered;
@property (nullable, nonatomic, retain) NSString *tags;
@property (nullable, nonatomic, retain) NSString *greeting;
@property (nullable, nonatomic, retain) NSString *favoriteFruit;

@end

NS_ASSUME_NONNULL_END
