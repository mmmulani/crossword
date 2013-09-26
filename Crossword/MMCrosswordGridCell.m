//
//  MMCrosswordGridCell.m
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "MMCrosswordGridCell.h"
#import "MMCrossword.h"

@implementation MMCrosswordGridCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)updateWithInfoFromCrossword:(MMCrossword *)crossword row:(NSUInteger)row column:(NSUInteger)column
{
  self.backgroundColor = [crossword isCellBlackAtRow:row column:column] ? [UIColor blackColor] : [UIColor whiteColor];
  self.letterLabel.text = [crossword characterAtRow:row column:column];
  NSNumber *gridNumber = [crossword gridNumberAtRow:row column:column];
  self.gridNumberLabel.text = [gridNumber isEqualToNumber:@0] ? @"" : [gridNumber stringValue];
}

@end
