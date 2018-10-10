//
//  DataBase.m
//  BHMTestApp
//
//  Created by Rostislav on 10/10/18.
//  Copyright © 2018 Ross. All rights reserved.
//

#import "DataBase.h"

@interface DataBase()

@property NSString *dbKey;

@end

@implementation DataBase

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

+ (instancetype)sharedInstance {
    
    static DataBase *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[DataBase alloc] init];
        sharedInstance.dbKey = @"BHMTestApp";
        [sharedInstance persistentContainer];

    });
    return sharedInstance;
}

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName: self.dbKey];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    _managedObjectContext = _persistentContainer.viewContext;
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
   
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
@end
