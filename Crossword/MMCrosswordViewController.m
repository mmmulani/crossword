//
//  MMCrosswordViewController.m
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

#import "MMCrosswordViewController.h"
#import "MMCrossword.h"

@interface MMCrosswordViewController ()

@end

@implementation MMCrosswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    return nil;
  }

  self.currentCrossword = [MMCrossword new];
  self.currentCrossword.rows = 15;
  self.currentCrossword.columns = 15;

  return self;
}

- (id)init
{
  return [self initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self.collectionView registerNib:[UINib nibWithNibName:@"MMCrosswordGridCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CrosswordGridCell"];
  NSUInteger width = self.currentCrossword.columns * 100 + (self.currentCrossword.columns - 1) * 5;
  NSUInteger height = self.currentCrossword.rows * 100 + (self.currentCrossword.rows - 1) * 5;
  self.collectionView.frame = CGRectMake(0, 0, width, height);
  self.gridScrollView.contentSize = CGSizeMake(width, height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
  return self.currentCrossword.rows * self.currentCrossword.columns;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CrosswordGridCell" forIndexPath:indexPath];
  cell.backgroundColor = [UIColor whiteColor];
  return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(100, 100);
}

#pragma mark - UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return self.collectionView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
  [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    ((UIView *)obj).layer.contentsScale = scale;
  }];
}

@end
