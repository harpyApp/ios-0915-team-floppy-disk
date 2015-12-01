//
//  HRPSettingsVC.m
//  harpy
//
//  Created by Kiara Robles on 11/23/15.
//  Copyright © 2015 teamFloppyDisk. All rights reserved.
//

#import "HRPSettingsVC.h"
#import "HRPParseNetworkService.h"

@interface HRPSettingsVC ()

@property (strong, nonatomic) HRPParseNetworkService *parseService;

- (IBAction)logout:(id)sender;

@end

@implementation HRPSettingsVC

#pragma mark - Lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavBar];
    
    self.parseService = [HRPParseNetworkService sharedService];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup methods

-(void)setupNavBar
{
    [[UINavigationBar appearance] setTitleTextAttributes: @{ NSFontAttributeName:
                                                                 [UIFont fontWithName:@"SFUIDisplay-Semibold" size:20.0],
                                                             NSForegroundColorAttributeName:[UIColor whiteColor]
                                                             }];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"backround_cropped"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - Action methods

- (IBAction)logout:(id)sender
{
    NSLog(@"CLICKED: logout button");
    
    {
        [self.parseService logout];
        [self performSegueWithIdentifier:@"sendToLogins" sender:sender];
    }
}

@end
