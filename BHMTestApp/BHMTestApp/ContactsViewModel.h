//
//  ContactsViewModel.h
//  BHMTestApp
//
//  Created by Rostislav on 10/10/18.
//  Copyright © 2018 Ross. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ContactsViewModelDelegate <NSObject>

- (void)viewModel:(id)viewModel indexPath:(NSIndexPath *)indexPath isRemove:(BOOL)isRemove;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ContactsViewModel : NSObject

@property NSMutableArray<Contacts *> *itemArray;
@property id <ContactsViewModelDelegate> delegate;

- (void)deletaItemForIndex:(NSIndexPath *)indexPath;
- (void)refreshData;

@end

NS_ASSUME_NONNULL_END
