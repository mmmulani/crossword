//
//  MMCrossword.h
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMCrossword : NSObject

@property NSUInteger rows;
@property NSUInteger columns;
@property NSString *gridString;
@property NSArray *gridNumbers;
@property NSMutableArray *gridProgress;

- (BOOL)isCellBlackAtRow:(NSUInteger)row column:(NSUInteger)column;
- (NSString *)characterAtRow:(NSUInteger)row column:(NSUInteger)column;
- (NSNumber *)gridNumberAtRow:(NSUInteger)row column:(NSUInteger)column;
- (BOOL)isCellSolvedAtRow:(NSUInteger)row column:(NSUInteger)column;
- (void)markCellSolvedAtRow:(NSUInteger)row column:(NSUInteger)column;

@end
