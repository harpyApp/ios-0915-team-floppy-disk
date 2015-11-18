//
//  HRPSpotifySearchViewController.m
//  harpy
//
//  Created by Kiara Robles on 11/17/15.
//  Copyright © 2015 teamFloppyDisk. All rights reserved.
//

#import "HRPSpotifySearchViewController.h"
#import <Spotify/Spotify.h>

@interface HRPSpotifySearchViewController ()

@property (nonatomic, strong) SPTSession *session;
@property (nonatomic, strong) SPTAudioStreamingController *player;

@end

@implementation HRPSpotifySearchViewController

- (void)viewDidLoad
{
    UIApplication *application = [UIApplication sharedApplication];
    
    
    [[SPTAuth defaultInstance] setClientID:@"51e5656ef4d34b6ea99023766c0c39b8"];
    [[SPTAuth defaultInstance] setRedirectURL:[NSURL URLWithString:@"olutosin123://returnafterlogin"]];
    [[SPTAuth defaultInstance] setRequestedScopes:@[SPTAuthStreamingScope]];

    // Construct a login URL and open it
    NSURL *loginURL = [[SPTAuth defaultInstance] loginURL];
    
    // Opening a URL in Safari close to application launch may trigger
    // an iOS bug, so we wait a bit before doing so.
    [application performSelector:@selector(openURL:)
                      withObject:loginURL afterDelay:0.1];
    
    // Ask SPTAuth if the URL given is a Spotify authentication callback
    if ([[SPTAuth defaultInstance] canHandleURL:loginURL])
    {
        [[SPTAuth defaultInstance] handleAuthCallbackWithTriggeredAuthURL:loginURL callback:^(NSError *error, SPTSession *session) {
            
            if (error != nil) {
                NSLog(@"*** Auth error: %@", error);
                return;
            }
            
            // Call the -playUsingSession: method to play a track
            [self playUsingSession:session];
        }];
    }

    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// Handle auth callback
-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation
{
    NSLog(@"here2");
    // Ask SPTAuth if the URL given is a Spotify authentication callback
    if ([[SPTAuth defaultInstance] canHandleURL:url]) {
        [[SPTAuth defaultInstance] handleAuthCallbackWithTriggeredAuthURL:url callback:^(NSError *error, SPTSession *session) {
            
            if (error != nil) {
                NSLog(@"*** Auth error: %@", error);
                return;
            }
            
            // Call the -playUsingSession: method to play a track
            [self playUsingSession:session];
        }];
        return YES;
    }
    
    return NO;
}

-(void)playUsingSession:(SPTSession *)session
{

    [SPTSearch performSearchWithQuery:@"michael+jackson" queryType:SPTQueryTypeTrack offset:0 accessToken:nil callback:^(NSError *error, SPTListPage *results) {
          NSLog(@"%@", [results.items[0] playableUri]);
        
        NSURL *temp = [results.items[0] playableUri];

        if (self.player == nil)
        {
            self.player = [[SPTAudioStreamingController alloc] initWithClientId:[SPTAuth defaultInstance].clientID];
        }
        
        [self.player loginWithSession:session callback:^(NSError *error) {
            if (error != nil) {
                NSLog(@"*** Logging in got error: %@", error);
                return;
            }
            
            //     NSURL *trackURI = [NSURL URLWithString:@"spotify:track:2LlQb7Uoj1kKyGhlkBf9aC"];
            
            NSURL *trackURI = temp;
            
            NSLog(@"%@", results.items[0]); // prints <SPTPartialTrack: 0x7fbb1a724da0>: Billie Jean - Single Version (spotify:track:5ChkMS8OtdzJeqyybCc9R5)
            
            SPTPartialTrack *myTrack = results.items[0];
            
            SPTImage *image = myTrack.album.largestCover;

        }];
  
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
