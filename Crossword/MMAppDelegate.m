//
//  MMAppDelegate.m
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

#import <Parse/Parse.h>
#import "PTPusher.h"
#import "PTPusherChannel.h"
#import "PTPusherEvent.h"

#import "MMAppDelegate.h"
#import "MMLoginViewController.h"
#import "MMCrosswordViewController.h"

@implementation MMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [Parse setApplicationId:@"xHafTZYqXbr1y9ESBUdFrrJmWWvDrS7LNESRSwWi" clientKey:@"zySqFT59VqcfbljUDdoiuRBQH06TMrxhttXoiBx7"];
  [PFFacebookUtils initializeFacebook];

  self.pusher = [PTPusher pusherWithKey:@"9a681f8753bc79535b23" delegate:self encrypted:NO];
  self.pusher.authorizationURL = [NSURL URLWithString:@"http://pusher.herokuapp.com/auth/private"];
  [self.pusher connect];

  PTPusherChannel *pusherChannel = [self.pusher subscribeToChannelNamed:@"private-mmm_crossword_LOL"];
  [pusherChannel bindToEventNamed:@"client-letter_typed" handleWithBlock:^(PTPusherEvent *pusherEvent) {
    UIViewController *viewController = self.window.rootViewController;
    if ([viewController isKindOfClass:[MMCrosswordViewController class]]) {
      [((MMCrosswordViewController *) viewController) didSolveCellAtRow:[pusherEvent.data[@"row"] integerValue] column:[pusherEvent.data[@"column"] integerValue] sendUpdate:NO];
    }
  }];

  [pusherChannel bindToEventNamed:@"client-needs_grid" handleWithBlock:^(PTPusherEvent *pusherEvent) {
    UIViewController *viewController = self.window.rootViewController;
    if ([viewController isKindOfClass:[MMCrosswordViewController class]]) {
      [self.pusher sendEventNamed:@"client-send_grid"
                             data:((MMCrosswordViewController *) viewController).currentCrossword.gridProgress
                          channel:@"private-mmm_crossword_LOL"];
    }
  }];

  [pusherChannel bindToEventNamed:@"client-send_grid" handleWithBlock:^(PTPusherEvent *pusherEvent) {
    UIViewController *viewController = self.window.rootViewController;
    if ([viewController isKindOfClass:[MMCrosswordViewController class]]) {
      [((MMCrosswordViewController *) viewController) updateGridWithProgress:pusherEvent.data];
    }
  }];

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  self.window.backgroundColor = [UIColor whiteColor];
  self.window.rootViewController = [PFUser currentUser] ? [MMCrosswordViewController new] : [MMLoginViewController new];

  [self.window makeKeyAndVisible];
  return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  return [PFFacebookUtils handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
  return [PFFacebookUtils handleOpenURL:url];
}

- (void)loginCompleted
{
  self.window.rootViewController = [MMCrosswordViewController new];
}

#pragma mark - PTPusherDelegate methods
- (void)pusher:(PTPusher *)pusher connectionDidConnect:(PTPusherConnection *)connection
{
  NSLog(@"Pusher connected!");
  [pusher sendEventNamed:@"client-needs_grid" data:nil channel:@"private-mmm_crossword_LOL"];
}

- (void)pusher:(PTPusher *)pusher connection:(PTPusherConnection *)connection failedWithError:(NSError *)error
{
  NSLog(@"Pusher failed with error: %@", error);
}

- (void)pusher:(PTPusher *)pusher connectionWillReconnect:(PTPusherConnection *)connection afterDelay:(NSTimeInterval)delay
{
  NSLog(@"Pusher could not connect, will reconnect");
}

@end
