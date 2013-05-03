//
//  CardGame.h
//  Matchismo
//
//  Created by Karl Lee on 2013-02-27.
//  Copyright (c) 2013 Karl Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (void)reset;

@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) NSString *flipResult;
@property (readonly, nonatomic) NSArray *flipHistory;
@property (nonatomic, getter = isMatch3mode) BOOL match3mode;

@end
