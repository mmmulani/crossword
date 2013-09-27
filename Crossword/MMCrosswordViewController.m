//
//  MMCrosswordViewController.m
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

#import "MMCrosswordViewController.h"
#import "MMCrossword.h"
#import "MMCrosswordGridCell.h"

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
  self.currentCrossword.gridString = @"BALL.DOZEN.HALFEPEE.IRATE.IDEASIAMESECAT.GMACTENON.SHIPSHAPE..INTO..LATENT.WON.EDYS.YER...EGG.RIOTS.SEGERSLOB.CLOCK.DODITENOR.KOALA.TAN...LUV.DRUM.OMG.SCOTIA..MILS..DEATHSTAR.GALOPAGRI.IAMACAMERAYULE.TRACY.PEERSEAS.SIDED.SPOT";
  self.currentCrossword.gridNumbers = @[@1, @2, @3, @4, @0, @5, @6, @7, @8, @9, @0, @10, @11, @12, @13, @14, @0, @0, @0, @0, @15, @0, @0, @0, @0, @0, @16, @0, @0, @0, @17, @0, @0, @0, @18, @0, @0, @0, @0, @0, @0, @19, @0, @0, @0, @20, @0, @0, @0, @0, @0, @21, @0, @0, @0, @22, @0, @0, @0, @0, @0, @0, @23, @0, @0, @24, @0, @0, @25, @0, @0, @0, @0, @0, @0, @26, @27, @0, @0, @28, @0, @29, @30, @0, @31, @0, @0, @0, @0, @0, @32, @0, @0, @0, @33, @0, @0, @0, @34, @0, @35, @0, @36, @37, @38, @39, @0, @0, @40, @0, @41, @0, @0, @0, @42, @0, @43, @0, @0, @0, @44, @0, @0, @0, @45, @0, @46, @0, @0, @0, @47, @0, @48, @0, @0, @0, @0, @0, @49, @0, @50, @0, @51, @0, @0, @0, @0, @52, @0, @0, @0, @53, @54, @0, @0, @0, @55, @0, @0, @56, @0, @57, @0, @0, @0, @58, @0, @0, @0, @0, @0, @0, @59, @60, @0, @61, @0, @0, @62, @63, @64, @0, @0, @0, @0, @65, @0, @0, @0, @66, @0, @0, @0, @0, @0, @67, @0, @0, @0, @0, @68, @0, @0, @0, @0, @0, @69, @0, @0, @0, @70, @0, @0, @0, @0, @71, @0, @0, @0, @0, @0, @72, @0, @0, @0];

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
  NSUInteger width = self.currentCrossword.columns * 60 + (self.currentCrossword.columns - 1) * 5;
  NSUInteger height = self.currentCrossword.rows * 60 + (self.currentCrossword.rows - 1) * 5;
  self.collectionView.frame = CGRectMake(0, 0, width, height);
  self.gridScrollView.contentSize = CGSizeMake(width, height);
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
  MMCrosswordGridCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CrosswordGridCell" forIndexPath:indexPath];
  NSUInteger itemNumber = indexPath.row;
  [cell updateWithInfoFromCrossword:self.currentCrossword row:(itemNumber / self.currentCrossword.columns) column:(itemNumber % self.currentCrossword.columns)];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if ([self.hiddenTextField isFirstResponder]) {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    [self.hiddenTextField resignFirstResponder];
  } else {
    if ([self.currentCrossword isCellBlackAtRow:(indexPath.row / self.currentCrossword.columns) column:(indexPath.row % self.currentCrossword.columns)]) {
      [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    } else {
      [self.hiddenTextField becomeFirstResponder];
    }
  }
}


#pragma mark - UICollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(60, 60);
}

#pragma mark - UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return self.collectionView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if ([self.hiddenTextField isFirstResponder]) {
    [self.hiddenTextField resignFirstResponder];
  }
}



@end
