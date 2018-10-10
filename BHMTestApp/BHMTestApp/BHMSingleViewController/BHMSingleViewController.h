//
//  BHMSingleViewController.h
//  BHMTestApp
//
//  Created by Rostislav on 10/10/18.
//  Copyright © 2018 Ross. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BHMSingleViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

+ (instancetype)showSingleContactViewController:(BHMSingleViewModel *)viewModel;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(BHMSingleViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
