//
//  MMCrosswordGridCell.h
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

@class MMCrossword;

#import <UIKit/UIKit.h>

@interface MMCrosswordGridCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *gridNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *letterLabel;

- (void)updateWithInfoFromCrossword:(MMCrossword *)crossword row:(NSUInteger)row column:(NSUInteger)column;

@end
