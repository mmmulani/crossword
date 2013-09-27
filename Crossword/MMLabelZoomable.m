//
//  MMLabelZoomable.m
//  Crossword
//
//  Created by Mehdi Mulani on 9/26/13.
//  Copyright (c) 2013 Mehdi Mulani. All rights reserved.
//

#import "MMLabelZoomable.h"

@implementation MMLabelZoomable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)didMoveToWindow
{
  [super didMoveToWindow];

  CATiledLayer *layerForView = (CATiledLayer *)self.layer;
  layerForView.levelsOfDetailBias = 2.0f;
  layerForView.levelsOfDetail = 2.0f;
}

+ (Class)layerClass
{
  return [CATiledLayer class];
}

@end
