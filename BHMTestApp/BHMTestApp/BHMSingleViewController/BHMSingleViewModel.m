//
//  BHMSingleViewModel.m
//  BHMTestApp
//
//  Created by Rostislav on 10/10/18.
//  Copyright © 2018 Ross. All rights reserved.
//

#import "BHMSingleViewModel.h"

@implementation BHMSingleViewModel

- (instancetype)initWithContactInfo:(NSDictionary *)contentInfo {
    self = [super init];
    if (self) {
        
        self.fildsArray = @[].mutableCopy;
        self.contentInfo = contentInfo.mutableCopy;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.fildsArray = @[].mutableCopy;
        self.contentInfo = @{ @"contactID": [self randomStringWithLength:10], @"firstName": @"", @"lastName": @"", @"state": @"", @"phoneNumber": @"", @"streetAddress1": @"", @"streetAddress2": @"", @"city": @"", @"zipCode": @"" }.mutableCopy;
    }
    return self;
}

- (NSArray<NSString *> *)placeholders{
    
    return @[@"firstName", @"lastName",@"phoneNumber", @"state", @"city", @"streetAddress1", @"streetAddress2", @"zipCode"];
}

- (NSString *)randomStringWithLength:(int)len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

- (void)addTextField:(UITextField *)textField{
    
    if (self.fildsArray.count < self.placeholders.count){
        
        [self.fildsArray addObject: textField];
    }
    
}
@end
