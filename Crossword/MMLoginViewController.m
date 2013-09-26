//
//  MMLoginViewController.m
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

#import <Parse/Parse.h>

#import "MMLoginViewController.h"
#import "MMAppDelegate.h"

@interface MMLoginViewController ()

@end

@implementation MMLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self.loginButton addTarget:self action:@selector(loginButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginButtonTapped
{
  [PFFacebookUtils logInWithPermissions:@[] block:^(PFUser *user, NSError *error) {
    NSLog(@"Logged in with user %@ and error %@", user, error);
    if (!error) {
      [((MMAppDelegate *)[UIApplication sharedApplication].delegate) loginCompleted];
    }
  }];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
