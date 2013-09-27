//
//  MMCrosswordViewController.h
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMCrossword;

typedef enum {
  MMClueOrientationVertical,
  MMClueOrientationHorizontal,
} MMClueOrientation;

@interface MMCrosswordViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *gridScrollView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *hiddenTextField;

@property NSUInteger currentRow;
@property NSUInteger currentColumn;
@property MMClueOrientation currentOrientation;

@property (strong, nonatomic) MMCrossword *currentCrossword;

- (void)didSolveCellAtRow:(NSUInteger)row column:(NSUInteger)column sendUpdate:(BOOL)sendUpdate;

@end
