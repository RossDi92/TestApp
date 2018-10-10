//
//  Contacts+CoreDataProperties.h
//  BHMTestApp
//
//  Created by Rostislav on 10/10/18.
//  Copyright © 2018 Ross. All rights reserved.
//
//

#import "Contacts+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Contacts (CoreDataProperties)

+ (NSFetchRequest<Contacts *> *)fetchRequest;
+ (Contacts *)addNewContact:(NSDictionary *)contactInfo;
+ (BOOL)updateContact:(NSDictionary *)contactInfo;
+ (BOOL)removeContactForPredicate:(NSString *)predic;

- (NSDictionary *)getDataFrorDict;

@property (nullable, nonatomic, copy) NSString *contactID;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *city;
@property (nullable, nonatomic, copy) NSString *zipCode;
@property (nullable, nonatomic, copy) NSString *state;
@property (nullable, nonatomic, copy) NSString *phoneNumber;
@property (nullable, nonatomic, copy) NSString *streetAddress1;
@property (nullable, nonatomic, copy) NSString *streetAddress2;

@end

NS_ASSUME_NONNULL_END
