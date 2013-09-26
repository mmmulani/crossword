//
//  MMAppDelegate.m
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

#import <Parse/Parse.h>

#import "MMAppDelegate.h"
#import "MMLoginViewController.h"
#import "MMCrosswordViewController.h"

@implementation MMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [Parse setApplicationId:@"xHafTZYqXbr1y9ESBUdFrrJmWWvDrS7LNESRSwWi" clientKey:@"zySqFT59VqcfbljUDdoiuRBQH06TMrxhttXoiBx7"];
  [PFFacebookUtils initializeFacebook];

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

@end
