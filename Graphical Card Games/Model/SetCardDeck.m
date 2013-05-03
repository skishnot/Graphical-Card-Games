//
//  SetCardDeck.m
//  Card Games
//
//  Created by Karl Lee on 2013-04-17.
//  Copyright (c) 2013 Karl Lee. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *symbol in [SetCard validSymbols]) {
            for (UIColor *colour in [SetCard validColours]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.shading = shading;
                        card.colour = colour;
                        card.symbol = symbol;
                        card.number = number;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
