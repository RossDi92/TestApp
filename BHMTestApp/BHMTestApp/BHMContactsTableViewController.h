//
//  BHMContactsTableViewController.h
//  BHMTestApp
//
//  Created by Rostislav on 10/10/18.
//  Copyright © 2018 Ross. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsViewModel.h"
#import "BHMSingleViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BHMContactsTableViewController : UITableViewController<ContactsViewModelDelegate>

@end

NS_ASSUME_NONNULL_END
