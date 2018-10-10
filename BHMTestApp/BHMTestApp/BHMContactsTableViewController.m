//
//  BHMContactsTableViewController.m
//  BHMTestApp
//
//  Created by Rostislav on 10/10/18.
//  Copyright © 2018 Ross. All rights reserved.
//

#import "BHMContactsTableViewController.h"

@interface BHMContactsTableViewController ()

@property ContactsViewModel* viewModel;
@end

@implementation BHMContactsTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.viewModel = [[ContactsViewModel alloc] init];
        self.viewModel.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib: [UINib nibWithNibName: NSStringFromClass([ListTableViewCell class])  bundle:nil] forCellReuseIdentifier: NSStringFromClass([ListTableViewCell class])];
    [self.tableView setEditing:YES animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: YES];
    [self.viewModel refreshData];
    [self.tableView reloadData];
}

- (IBAction)addNewAction:(id)sender {
    
    [self.navigationController pushViewController: [BHMSingleViewController showSingleContactViewController: [BHMSingleViewModel new]] animated: YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.viewModel.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([ListTableViewCell class]) forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell isKindOfClass:([ListTableViewCell class])]) {
        
        ListTableViewCell *updateCell = (ListTableViewCell *)cell;
        updateCell.titleLabel.text = [NSString stringWithFormat:@"%@ %@", [self.viewModel.itemArray objectAtIndex:indexPath.row].firstName, [self.viewModel.itemArray objectAtIndex:indexPath.row].lastName];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BHMSingleViewModel *viewModel = [[BHMSingleViewModel alloc] initWithContactInfo: self.viewModel.itemArray[indexPath.row].getDataFrorDict];
    [self.navigationController pushViewController: [BHMSingleViewController showSingleContactViewController: viewModel] animated: YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [self.viewModel deletaItemForIndex: indexPath];
    }
}

#pragma mark - ContactsViewModelDelegate

- (void)viewModel:(id)viewModel indexPath:(NSIndexPath *)indexPath isRemove:(BOOL)isRemove{
    
    if (isRemove){

        [self.viewModel.itemArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

@end
