//
//  MMCrossword.m
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

#import "MMCrossword.h"

@implementation MMCrossword

- (BOOL)isCellBlackAtRow:(NSUInteger)row column:(NSUInteger)column
{
  return [[self characterAtRow:row column:column] isEqualToString:@"."];
}

- (NSString *)characterAtRow:(NSUInteger)row column:(NSUInteger)column
{
  unichar character = [self.gridString characterAtIndex:(row * self.columns + column)];
  return [NSString stringWithCharacters:&character length:1];
}

- (NSNumber *)gridNumberAtRow:(NSUInteger)row column:(NSUInteger)column
{
  return self.gridNumbers[row * self.columns + column];
}

- (BOOL)isCellSolvedAtRow:(NSUInteger)row column:(NSUInteger)column
{
  return [self.gridProgress[row * self.columns + column] boolValue];
}

- (void)markCellSolvedAtRow:(NSUInteger)row column:(NSUInteger)column
{
  self.gridProgress[row * self.columns + column] = @YES;
}

@end
