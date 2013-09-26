//
//  MMCrosswordViewController.h
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMCrossword;

@interface MMCrosswordViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *gridScrollView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) MMCrossword *currentCrossword;

@end
