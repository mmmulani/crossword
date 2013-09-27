//
//  MMAppDelegate.h
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTPusherDelegate;
@class PTPusher;

@interface MMAppDelegate : UIResponder <UIApplicationDelegate, PTPusherDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PTPusher *pusher;

- (void)loginCompleted;

@end
