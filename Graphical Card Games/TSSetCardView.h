//
//  TSSetCardView.h
//  Graphical Card Games
//
//  Created by Karl Lee on 2013-05-06.
//  Copyright (c) 2013 Twilight Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface TSSetCardView : UIView

@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) UIColor *colour;
@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSAttributedString *stylizedContents;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;

@end
