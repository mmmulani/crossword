//
//  MMCrossword.h
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  MMClueOrientationVertical,
  MMClueOrientationHorizontal,
} MMClueOrientation;

@interface MMCrossword : NSObject

@property NSUInteger rows;
@property NSUInteger columns;
@property NSString *gridString;
@property NSArray *gridNumbers;
@property NSMutableArray *gridProgress;
@property NSArray *acrossClues;
@property NSArray *downClues;

- (BOOL)isCellBlackAtRow:(NSUInteger)row column:(NSUInteger)column;
- (NSString *)characterAtRow:(NSUInteger)row column:(NSUInteger)column;
- (NSNumber *)gridNumberAtRow:(NSUInteger)row column:(NSUInteger)column;
- (BOOL)isCellSolvedAtRow:(NSUInteger)row column:(NSUInteger)column;
- (void)markCellSolvedAtRow:(NSUInteger)row column:(NSUInteger)column;
- (NSString *)clueAtRow:(NSInteger)row column:(NSInteger)column direction:(MMClueOrientation)orientation;

@end
