//
//  HRPUserSearchVC.m
//  harpy
//
//  Created by Kiara Robles on 11/24/15.
//  Copyright © 2015 teamFloppyDisk. All rights reserved.
//

#import "HRPUserSearchVC.h"
#import "HRPUser.h"
#import <Parse/Parse.h>

@interface HRPUserSearchVC ()  <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UISearchBar *userSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic) PFUser *user;
@property (nonatomic) NSMutableArray *users;

@end

@implementation HRPUserSearchVC

#pragma mark - Lifecyle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    
    [self initializeEmptyUsersArray];
    
    PFQuery *query = [PFUser query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error)
        {
            NSLog(@"PFUser COUNT: %lu", (unsigned long)objects.count);
            self.users = [objects mutableCopy];
        } else
        {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    [self.userTableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated {
    [self.userTableView deselectRowAtIndexPath:[self.userTableView indexPathForSelectedRow] animated:animated];
    [super viewWillAppear:animated];
}

-(void)initializeEmptyUsersArray {
    self.users = [NSMutableArray new];
}

#pragma mark - Search bar methods

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

}

#pragma mark - UITableViewDataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.userTableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    PFUser *user = [self.users objectAtIndex:[indexPath row] + 1]; // Add one since array count starts at 0
    cell.textLabel.text = user.username;
    
    return cell;
}

@end
