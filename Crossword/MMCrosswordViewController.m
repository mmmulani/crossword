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
#import "MMAppDelegate.h"
#import "PTPusher.h"

@interface MMCrosswordViewController ()

@property CGRect keyboardFrame;
@property BOOL isCenteringCell;

- (void)keyboardDidChangeFrame:(NSNotification *)notification;
- (void)centerOnSelectedCell;

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
  self.currentCrossword.gridProgress = [NSMutableArray array];
  for (NSUInteger i = 0; i < self.currentCrossword.rows * self.currentCrossword.columns; i++) {
    [self.currentCrossword.gridProgress addObject:@NO];
  }
  self.currentOrientation = MMClueOrientationHorizontal;

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

  self.hiddenTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillChangeFrame:)
                                               name:UIKeyboardWillChangeFrameNotification
                                             object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
  self.keyboardFrame = [self.view convertRect:[[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]
                                     fromView:nil];
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
    [self.hiddenTextField becomeFirstResponder];
    NSUInteger itemNumber = indexPath.row;
    NSUInteger column = itemNumber % self.currentCrossword.columns;
    NSUInteger row = itemNumber / self.currentCrossword.columns;
    [self _selectCellAtRow:row column:column];
  }
}

- (void)_selectCellAtRow:(NSUInteger)row column:(NSUInteger)column
{
  // TODO: Validate that row and column exist and they do not reference a black cell.
  // LOL, we should really be tracking whether we are in editing mode.
  NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:(self.currentRow * self.currentCrossword.columns + self.currentColumn) inSection:0];
  if ([self.hiddenTextField isFirstResponder]) {
    [self.collectionView deselectItemAtIndexPath:currentIndexPath animated:NO];
  }

  [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:(row * self.currentCrossword.columns + column) inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
  self.currentRow = row;
  self.currentColumn = column;
  [self centerOnSelectedCell];
}

- (void)centerOnSelectedCell {
  UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[[self.collectionView indexPathsForSelectedItems] lastObject]];

  self.isCenteringCell = YES;
  [UIView animateWithDuration:0.2f animations:^{
    CGPoint contentOffset = cell.frame.origin;

    self.gridScrollView.zoomScale = 1.0f;
    contentOffset.x -= 30;
    contentOffset.y -= self.keyboardFrame.origin.y - 60 - self.gridScrollView.frame.origin.y - 30;
    contentOffset.x = MIN(self.gridScrollView.contentSize.width - self.gridScrollView.bounds.size.width + 30, contentOffset.x);
    contentOffset.x = MAX(-30, contentOffset.x);
    contentOffset.y = MAX(-30, contentOffset.y);
    self.gridScrollView.contentOffset = contentOffset;
    self.isCenteringCell = NO;
  }];
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
  if (!self.isCenteringCell && [self.hiddenTextField isFirstResponder]) {
    [self.hiddenTextField resignFirstResponder];
    [self.collectionView deselectItemAtIndexPath:[[self.collectionView indexPathsForSelectedItems] lastObject] animated:YES];
  }
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  NSString *letterToEnter = [string uppercaseString];
  NSLog(@"Letter to enter is %@, correct letter is %@", letterToEnter, [self.currentCrossword characterAtRow:self.currentRow column:self.currentColumn]);

  if ([letterToEnter isEqualToString:[self.currentCrossword characterAtRow:self.currentRow column:self.currentColumn]]) {
    [self didSolveCellAtRow:self.currentRow column:self.currentColumn sendUpdate:YES];

    [self _selectCellAtRow:self.currentRow column:(self.currentColumn + 1)];
  }
  return YES;
}

#pragma mark - Updating the board

- (void)didSolveCellAtRow:(NSUInteger)row column:(NSUInteger)column sendUpdate:(BOOL)sendUpdate
{
  if ([self.currentCrossword isCellSolvedAtRow:row column:column]) {
    return;
  }

  [self.currentCrossword markCellSolvedAtRow:self.currentRow column:self.currentColumn];
  
  if (sendUpdate) {
    NSDictionary *pusherData =
    @{
      @"row": @(row),
      @"column": @(column),
      };
    [((MMAppDelegate *)[UIApplication sharedApplication].delegate).pusher sendEventNamed:@"client-letter_typed" data:pusherData channel:@"private-mmm_crossword_LOL"];
  }
  
  MMCrosswordGridCell *cell = (MMCrosswordGridCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:(self.currentRow * self.currentCrossword.columns + self.currentColumn) inSection:0]];
  [cell updateWithInfoFromCrossword:self.currentCrossword row:self.currentRow column:self.currentColumn];
}

@end
