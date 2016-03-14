//
//  DMBaseViewController.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "DMBaseViewController.h"
#import "DMServiceManager.h"
#import "GlobalConstants.h"
#import "Utils.h"

@interface DMBaseViewController ()

@end

@implementation DMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    //Load the data, download, save to db, etc. This code should be moved to a loading (first) controller
    self.coreDataStack = [kDMStorageManager getCurrentCoreDataStack];
    if (!_coreDataStack) {
        
        __weak __typeof(self)weakSelf = self;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        [kDMStorageManager initCoreDataStackForDbName:AppDatabaseName withCompletionBlock:^(NSError *error, id dataResult) {
            
            weakSelf.coreDataStack = [kDMStorageManager getCurrentCoreDataStack];
            
            if (error) {
                NSLog(@"Cannot init db.");
            }else{
                
                if ([userDefaults valueForKey:IsDataParsedKey] == nil) {
                    
                    
                    [kDMServiceManager downloadAndSaveAllClubsWithCompletionBlock:^(NSError *serviceCallError, id dataResult) {
                        if (serviceCallError) {
                            NSLog(@"ceva eroare ");
                        }else
                        {
                            NSLog(@"Download and save complete");
                            [userDefaults setValue:@"ceva" forKey:IsDataParsedKey];
                            [userDefaults synchronize];
                        }
                    }];
                }else
                {
                }
                
            }
        }];
    }

}


#pragma mark - Rotation
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

@end
