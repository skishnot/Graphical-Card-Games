//
//  TSPlayingCardView.h
//  Graphical Card Games
//
//  Created by Karl Lee on 2013-05-03.
//  Copyright (c) 2013 Twilight Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface TSPlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;

@end
