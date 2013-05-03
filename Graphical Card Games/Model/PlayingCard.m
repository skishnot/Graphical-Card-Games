//
//  PlayingCard.m
//  Matchismo
//
//  Created by Karl Lee on 2013-02-22.
//  Copyright (c) 2013 Karl Lee. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 2;
        } else if (otherCard.rank == self.rank) {
            score = 5;
        }
    } else if ([otherCards count] == 2){
        PlayingCard *card1 = otherCards[0];
        PlayingCard *card2 = otherCards[1];
        
        // account for matching all 3
        // check suit first
        if ([self.suit isEqualToString:card1.suit] && [self.suit isEqualToString:card2.suit]) {
            // if suits match, you win lots of points
            score = 70;
            
            // check to see if ranks match (no need to check further)
        } else if ((self.rank == card1.rank) && (self.rank == card2.rank)) {
            score = 2200;

            // account for matching 2
        } else if ([self.suit isEqualToString:card1.suit] || [self.suit isEqualToString:card2.suit]) {
            // check suits first
            // check if ranks match as well
            if ((self.rank == card1.rank) || (self.rank == card2.rank)) {
                // if so, then awesome for you!
                score = 4000;
            } else {
                // if not, you still win points
                score = 20;
            }
        } else if ((self.rank == card1.rank) || (self.rank == card2.rank)) {
            // if only ranks match, score is given as well
            score = 200;
        }
    }
    
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we have our own getter & setter

+ (NSArray *)validSuits {
    return @[@"♥", @"♦", @"♠", @"♣"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
} //setter for suit

- (NSString *)suit {
    return _suit ? _suit : @"?";
} // getter for suit

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3",@"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank { return [self rankStrings].count-1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
