//
//  CardGame.m
//  Matchismo
//
//  Created by Karl Lee on 2013-02-27.
//  Copyright (c) 2013 Karl Lee. All rights reserved.
//

#import "CardGame.h"

@interface CardGame ()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (readwrite, nonatomic) NSString *flipResult;
@property (readwrite, nonatomic) NSArray *flipHistory;
@end

@implementation CardGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    if (!self.isMatch3mode) {
        [self match2logic:index];
        NSLog(@"match 2 logic in place");
    } else {
        [self match3logic:index];
        NSLog(@"match 3 logic in place");
    }
}

-(NSArray *)flipHistory
{
    if (!_flipHistory) _flipHistory = [[NSArray alloc] init];
    return _flipHistory;
}

-(void)setFlipResult:(NSString *)flipResult
{
    _flipResult = flipResult;
    self.flipHistory = [self.flipHistory arrayByAddingObject:_flipResult];
}

- (void)match2logic:(NSUInteger)index
{
    // flip a card #1, report
    Card *card = [self cardAtIndex:index];
    NSLog(@"Flipped %@", card.contents);
    self.flipResult = [NSString stringWithFormat:@"Flipped %@", card.contents];
    
    // if it is playable
    if (!card.isUnplayable) {
        
        // and the card is face down
        if (!card.isFaceUp) {
            
            // then "flip" the card, and subtract 1 point for flipping a card
            card.faceUp = !card.isFaceUp;
            self.score -= FLIP_COST;
            
            // then look through other cards
            for (Card *otherCard in self.cards) {
                // and for each Other Card that is face up and playable
                if (otherCard.isFaceUp && !otherCard.isUnplayable && (otherCard != card)) {
                    
                    // see if it is a match
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        
                        // if yes, both cards are now unplayable
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        
                        // calculate the score, then report
                        self.score += matchScore * MATCH_BONUS;
                        NSLog(@"Matched. %@ & %@ for %d points.", card.contents, otherCard.contents, matchScore * MATCH_BONUS);
                        self.flipResult = [NSString stringWithFormat:@"%@ & %@ are a match! Gained %d points.", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                        
                    } else {
                        
                        // if no, flip down the Other Crad, penalty is applied, then report
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        NSLog(@"Not a match. %@ & %@ for -%d points.", card.contents, otherCard.contents, MISMATCH_PENALTY);
                        self.flipResult = [NSString stringWithFormat:@"%@ & %@ are not a match. Lost %d points.", card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    
                    // for loop is broken if a card was found
                    break;
                }
            }
        }
    }
}

-(void)match3logic:(NSUInteger)index
{
    // define card #1, then check if it's playable and face down
    Card *card1 = [self cardAtIndex:index];
    if (!card1.isUnplayable && !card1.isFaceUp) {
        
        // then "flip" the card, and subtract 1 point for flipping a card
        card1.faceUp = !card1.isFaceUp;
        self.score -= FLIP_COST;
        NSLog(@"Flipped %@", card1.contents);
        self.flipResult = [NSString stringWithFormat:@"Flipped %@", card1.contents];
        
        // then find another flipped card, and report if there is one
        for (Card *card2 in self.cards) {
            if (!card2.isUnplayable && card2.isFaceUp && (card1 != card2)) {
                self.flipResult = [NSString stringWithFormat:@"Flipped %@ and %@", card1.contents, card2.contents];
                
                // then look for the third card
                for (Card *card3 in self.cards) {
                    
                    //if there is the third card, check for its match score
                    if (!card3.isUnplayable && card3.isFaceUp && (card3 != card1) && (card3 != card2)) {
                        int matchScore = [card1 match:@[card2, card3]];
                        
                        // if there is a match score, all cards are now unplayable
                        if (matchScore) {
                            card1.unplayable = YES;
                            card2.unplayable = YES;
                            card3.unplayable = YES;
                            self.score += matchScore * MATCH_BONUS;
                            self.flipResult = [NSString stringWithFormat:@"A match found among %@, %@, and %@! Gained %d points!", card1.contents, card2.contents, card3.contents, matchScore * MATCH_BONUS];
                        } else {
                            // if no score, all cards are turned face down, and a penalty is applied
                            card1.faceUp = NO;
                            card2.faceUp = NO;
                            card3.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            self.flipResult = [NSString stringWithFormat:@"No match found in %@, %@, and %@. Lost %d points :(", card1.contents, card2.contents, card3.contents, MISMATCH_PENALTY];
                        }
                        // break for-loop if the third card is found.
                        break;
                    }
                }
            }
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card; // lazy instantiation
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (void)reset
{
    self.score = 0;
    self.flipResult = @"Matchismo!";
}

@end
