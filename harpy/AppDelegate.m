//
//  AppDelegate.m
//  harpy
//
//  Created by Kiara Robles on 11/16/15.
//  Copyright © 2015 teamFloppyDisk. All rights reserved.
//

#import "AppDelegate.h"
#import <Spotify/Spotify.h>
#import <AVFoundation/AVFoundation.h> // Required for Spotify
#import <Parse/Parse.h>
#import "HRPTrackCreator.h"
#import "HRPTrack.h"

@import GoogleMaps;

@interface AppDelegate ()



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Get API Key from key.plist (hidden by .gitignore)
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Keys" ofType:@"plist"]];
    
    //Google Keys
    NSString *googleMapAPIKey = [plistDictionary objectForKey:@"googleMapAPIKey"];
    [GMSServices provideAPIKey:googleMapAPIKey];
    
    //Spotify Keys
    NSString *spotifyClientId = [plistDictionary objectForKey:@"spotifyClientId"];
    self.spotifyClientId = @"804eb482ff2349f2b902a7774bfe58ce";
    NSString *spotifyClientSecret = [plistDictionary objectForKey:@"spotifyClientSecret"];

    //Parse Keys
    NSString *parseApplicationKey = [plistDictionary objectForKey:@"parseApplicationKey"];
    NSString *parseClientKey = [plistDictionary objectForKey:@"parseClientKey"];

    [Parse enableLocalDatastore];
    [Parse setApplicationId:parseApplicationKey
                  clientKey:parseClientKey];
    
    //Spotify Authorization Initializers
    SPTAuth *auth = [SPTAuth defaultInstance];
    auth.clientID = spotifyClientId;
    auth.requestedScopes = @[SPTAuthStreamingScope];
    auth.redirectURL = [NSURL URLWithString:@"harpy-app://authorize"];
    auth.tokenSwapURL = [NSURL URLWithString:@"https://ios-0915-floppy-disk.herokuapp.com/swap"];
    auth.tokenRefreshURL = [NSURL URLWithString:@"https://ios-0915-floppy-disk.herokuapp.com/refresh"];
    //auth.sessionUserDefaultsKey
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    SPTAuth *auth = [SPTAuth defaultInstance];
    
    SPTAuthCallback authCallback = ^(NSError *error, SPTSession *session) {
        // This is the callback that'll be triggered when auth is completed (or fails).
        
        if (error != nil) {
            NSLog(@"*** Auth error: %@", error);
            return;
        }
        
        auth.session = session;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sessionUpdated" object:self];
    };
    
    /*
     Handle the callback from the authentication service. -[SPAuth -canHandleURL:]
     helps us filter out URLs that aren't authentication URLs (i.e., URLs you use elsewhere in your application).
     */
    
    if ([auth canHandleURL:url]) {
        [auth handleAuthCallbackWithTriggeredAuthURL:url callback:authCallback];
        return YES;
    }
    
    return NO;
}

@end
