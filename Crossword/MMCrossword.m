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

- (NSString *)clueAtRow:(NSInteger)row column:(NSInteger)column direction:(MMClueOrientation)orientation
{
  NSNumber *clueNumber = @0;
  if (orientation == MMClueOrientationVertical) {
    while (row >= 0 && ![self isCellBlackAtRow:row column:column]) {
      clueNumber = [self gridNumberAtRow:row column:column];
      row--;
    }
  } else {
    while (column >= 0 && ![self isCellBlackAtRow:row column:column]) {
      clueNumber = [self gridNumberAtRow:row column:column];
      column--;
    }
  }

  NSArray *searchArray = orientation == MMClueOrientationHorizontal ? self.acrossClues : self.downClues;
  NSString *searchString = [clueNumber.stringValue stringByAppendingString:@"."];
  for (NSString *clue in searchArray) {
    if ([[clue substringWithRange:NSMakeRange(0, searchString.length)] isEqualToString:searchString]) {
      return clue;
    }
  }

  return nil;
}

@end
