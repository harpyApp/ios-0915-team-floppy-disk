//
//  HRPPostFeedViewController.h
//  harpy
//
//  Created by Phil Milot on 12/4/15.
//  Copyright © 2015 teamFloppyDisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface HRPPostFeedViewController : UIViewController
{
    NSMutableArray *postArray;
}

@property (strong, nonatomic) NSMutableArray *postsArray;

@end
