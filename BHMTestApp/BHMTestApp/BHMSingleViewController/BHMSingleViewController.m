//
//  BHMSingleViewController.m
//  BHMTestApp
//
//  Created by Rostislav on 10/10/18.
//  Copyright © 2018 Ross. All rights reserved.
//

#import "BHMSingleViewController.h"
#import "BHMInputTableViewCell.h"

@interface BHMSingleViewController ()

@property BHMSingleViewModel *viewModel;

@end

@implementation BHMSingleViewController

+ (instancetype)showSingleContactViewController:(BHMSingleViewModel *)viewModel{
    
    return [[BHMSingleViewController alloc] initWithNibName:NSStringFromClass([BHMSingleViewController class]) bundle: nil viewModel:viewModel];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(BHMSingleViewModel *)viewModel{
    
    self = [super initWithNibName:nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName: NSStringFromClass([BHMInputTableViewCell class]) bundle:nil] forCellReuseIdentifier: NSStringFromClass([BHMInputTableViewCell class])];
    [self addSaveBuuton];
}

- (void)addSaveBuuton{
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action: @selector(saveAction)];
    [save setEnabled: NO];
    [self.navigationItem setRightBarButtonItem: save];
}

- (void)saveAction{
    
    [self.view endEditing: YES];
    
    if (![Contacts updateContact: self.viewModel.contentInfo]) {
        
        [self.viewModel.contentInfo setValue:[self.viewModel randomStringWithLength:10] forKey:@"contactID"];
        
        [Contacts addNewContact: self.viewModel.contentInfo];
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark - UITableView Support

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.viewModel placeholders].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([BHMInputTableViewCell class])];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell isKindOfClass:[BHMInputTableViewCell class]]) {
        
        BHMInputTableViewCell *updateCell = (BHMInputTableViewCell *)cell;
        
        [self.viewModel addTextField: updateCell.inputField];
        updateCell.inputField.delegate = self;
        updateCell.inputField.placeholder = [self.viewModel placeholders][indexPath.row];
        updateCell.inputField.text = [self.viewModel.contentInfo objectForKey:[self.viewModel placeholders][indexPath.row]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.viewModel.fildsArray[0]]) {
        
        [self.viewModel.contentInfo setObject:textField.text forKey:@"firstName"];
    }
    
    if ([textField isEqual:self.viewModel.fildsArray[1]]) {
        
        [self.viewModel.contentInfo setObject:textField.text forKey:@"lastName"];
    }
    
    if ([textField isEqual:self.viewModel.fildsArray[2]]) {
        
        [self.viewModel.contentInfo setObject:textField.text forKey:@"state"];
    }
    
    if ([textField isEqual:self.viewModel.fildsArray[3]]) {
        
        [self.viewModel.contentInfo setObject:textField.text forKey:@"phoneNumber"];
    }
    
    if ([textField isEqual:self.viewModel.fildsArray[4]]) {
        
        [self.viewModel.contentInfo setObject:textField.text forKey:@"streetAddress1"];
    }
    
    if ([textField isEqual:self.viewModel.fildsArray[5]]) {
        
        [self.viewModel.contentInfo setObject:textField.text forKey:@"streetAddress2"];
    }
    
    if ([textField isEqual:self.viewModel.fildsArray[6]]) {
        
        [self.viewModel.contentInfo setObject:textField.text forKey:@"city"];
    }
    
    
    if ([textField isEqual:self.viewModel.fildsArray[7]]) {
        
        [self.viewModel.contentInfo setObject:textField.text forKey:@"zipCode"];
    }
}

@end
