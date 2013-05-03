//
//  SetCard.h
//  Card Games
//
//  Created by Karl Lee on 2013-04-17.
//  Copyright (c) 2013 Karl Lee. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) UIColor *colour;
@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSAttributedString *stylizedContents;

+(NSArray *)validSymbols;
+(NSArray *)validShadings;
+(NSArray *)validColours;
+(NSUInteger)maxNumber;

@end
