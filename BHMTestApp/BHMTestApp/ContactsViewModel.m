//
//  ContactsViewModel.m
//  BHMTestApp
//
//  Created by Rostislav on 10/10/18.
//  Copyright © 2018 Ross. All rights reserved.
//

#import "ContactsViewModel.h"

@implementation ContactsViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.itemArray = @[].mutableCopy;
        [self getLocalData];
    }
    return self;
}

- (void)getLocalData{
    
    [[self readLocalJSON] enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![Contacts updateContact:obj]){
            
            [Contacts addNewContact: obj];
        }
    }];
    
    [self refreshData];
}

- (void)refreshData{
    
    self.itemArray = [DataBase.sharedInstance.managedObjectContext executeFetchRequest:[Contacts fetchRequest] error:nil].mutableCopy;

}

- (NSArray<NSDictionary *> *)readLocalJSON{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"local" ofType:@"json"];
    
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    NSArray *jsonDataArray = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    return jsonDataArray;
}

- (void)deletaItemForIndex:(NSIndexPath *)indexPath {
    
    
    [self.delegate viewModel:self indexPath:indexPath isRemove:[Contacts removeContactForPredicate: self.itemArray[indexPath.row].contactID]];
}
@end
