//
//  Contacts+CoreDataProperties.m
//  BHMTestApp
//
//  Created by Rostislav on 10/10/18.
//  Copyright © 2018 Ross. All rights reserved.
//
//

#import "Contacts+CoreDataProperties.h"

@implementation Contacts (CoreDataProperties)

+ (NSFetchRequest<Contacts *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Contacts"];
}

@dynamic contactID;
@dynamic firstName;
@dynamic lastName;
@dynamic city;
@dynamic zipCode;
@dynamic state;
@dynamic phoneNumber;
@dynamic streetAddress1;
@dynamic streetAddress2;

+ (Contacts *)addNewContact:(NSDictionary *)contactInfo{
    
    NSManagedObjectContext *context = [[DataBase sharedInstance] managedObjectContext];
    
    NSManagedObject *newObject = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts" inManagedObjectContext:context];
    
    [contactInfo enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [newObject setValue:obj forKey:key];
    }];
    
    NSError *error = nil;
    
    if ([context save:&error]) {
        NSLog(@"data saved");
        return (Contacts *)newObject;
    }
    else{
        NSLog(@"Error occured while saving");
        return nil;
    }
}

+ (BOOL)updateContact:(NSDictionary *)contactInfo{
    
    NSManagedObject *oldObject = [Contacts getObjectForPredicate: contactInfo[@"contactID"]];
    NSError *error = nil;
    
    if (oldObject){
        
        [contactInfo enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            [oldObject setValue:obj forKey:key];
        }];
        
        if ([[[DataBase sharedInstance] managedObjectContext] save:&error]) {
            NSLog(@"data saved");
            
            return YES;
        }
        else{
            NSLog(@"Error occured while saving");
            return NO;
        }
    }
    
    return NO;
}

+ (BOOL)removeContactForPredicate:(NSString *)predic{
    
    NSManagedObject *oldObject = [Contacts getObjectForPredicate: predic];
    NSError *error = nil;
    
    if (oldObject){
        
        [[[DataBase sharedInstance] managedObjectContext] deleteObject:oldObject];
        
        if ([[[DataBase sharedInstance] managedObjectContext] save:&error]) {
            NSLog(@"data saved");
            return YES;
        }
        else{
            NSLog(@"Error occured while saving");
            return NO;
        }
    }
    
    return NO;
}

+ (NSManagedObject *)getObjectForPredicate:(NSString *)predic{
    
    NSMutableArray *results = @[].mutableCopy;
    
    NSFetchRequest<Contacts *> *request = Contacts.fetchRequest;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"contactID == %@", predic];
    [request setPredicate:predicate];
    
    NSManagedObjectContext *context = [[DataBase sharedInstance] managedObjectContext];
    
    results = [context executeFetchRequest:request error:nil].mutableCopy;
    
    NSManagedObject *newObject = results.firstObject;
    
    return newObject;
}

- (NSDictionary *)getDataFrorDict{
    
    return @{ @"contactID": self.contactID, @"firstName": self.firstName, @"lastName": self.lastName, @"state": self.state, @"phoneNumber": self.phoneNumber, @"streetAddress1": self.streetAddress1, @"streetAddress2": self.streetAddress2 , @"city": self.city, @"zipCode": self.zipCode };
}

@end
