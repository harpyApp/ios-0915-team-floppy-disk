//
//  HRPSettingsTableVC.m
//  harpy
//
//  Created by Kiara Robles on 12/7/15.
//  Copyright © 2015 teamFloppyDisk. All rights reserved.
//

#import "HRPSettingsTableVC.h"
#import "HRPParseNetworkService.h"
#import "Constants.h"

@interface HRPSettingsTableVC ()

@property (strong, nonatomic) HRPParseNetworkService *parseService;

@end

@implementation HRPSettingsTableVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    self.view.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0.98 alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Tableview data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"accountHeaderCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"buttonCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"spacyCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"logoutCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat customTableCellHeight = 0.0;
    
    if (indexPath.row == 0)
    {
        customTableCellHeight = self.view.frame.size.height/13;
    }
    if (indexPath.row == 1)
    {
        customTableCellHeight = self.view.frame.size.height/13;
    }
    if (indexPath.row == 2)
    {
        customTableCellHeight = self.view.frame.size.height/1.8f;
    }
    if (indexPath.row == 3)
    {
        customTableCellHeight = self.view.frame.size.height/13;
    }
    
    return customTableCellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell selected at %ld", indexPath.row);
    
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"sendToEditProfile" sender:self];
    }
    if (indexPath.row == 3) {
        [self logoutclicked];
    }
}

#pragma mark - Action Methods

- (IBAction)backButtonTapped:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)logoutclicked
{
    NSLog(@"CLICKED: logout button");
    
    [self.parseService logout];
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogOutNotificationName object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end