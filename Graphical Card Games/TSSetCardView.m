//
//  TSSetCardView.m
//  Graphical Card Games
//
//  Created by Karl Lee on 2013-05-06.
//  Copyright (c) 2013 Twilight Soft. All rights reserved.
//

#import "TSSetCardView.h"

@implementation TSSetCardView

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CARD_CORNER_RADIUS];
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    [self drawContents];
    
    // Change soon - Set Cards show contents even when face-down
//    if (self.isFaceUp) {
//        [self drawContents];
//    } else {
//        [[UIImage imageNamed:CARD_BACK_IMAGE] drawInRect:self.bounds];
//    }
}

- (void)drawContents
{
    // Draw stylized contents
    CGRect textbounds;
    textbounds.size = [self.stylizedContents size];
    float height = textbounds.size.height;
    float width = textbounds.size.width;
    float x = (self.bounds.size.width - width) / 2;
    float y = (self.bounds.size.height - height) / 2;
    textbounds.origin = CGPointMake(x, y);
    
    [self.stylizedContents drawInRect:textbounds];
}

#pragma mark - Initialization

- (void)setup
{
    // Do initialization here
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}


@end
