//
//  SetCardGame.m
//  Card Games
//
//  Created by Karl Lee on 2013-04-18.
//  Copyright (c) 2013 Karl Lee. All rights reserved.
//

#import "SetCardGame.h"

@interface SetCardGame()

@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards;
@property (readwrite, nonatomic) NSString *flipResult;
@property (readwrite, nonatomic) NSAttributedString *stylizedFlipResult;

@end

@implementation SetCardGame

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

-(void)flipCardAtIndex:(NSUInteger)index
{
    // define card #1, then check if it's playable and face down
    SetCard *card1 = (SetCard *)[self cardAtIndex:index];
    if (!card1.isUnplayable && !card1.isFaceUp) {
        
        // then "flip" the card (selected in this case), and subtract 1 point for flipping a card
        card1.faceUp = !card1.isFaceUp;
        self.score -= FLIP_COST;
        self.stylizedFlipResult = [self assembleFlipResult:@[card1]];
        
        // then find another flipped (selected) card, and report if there is one
        for (SetCard *card2 in self.cards) {
            if (!card2.isUnplayable && card2.isFaceUp && (card1 != card2)) {
                self.stylizedFlipResult = [self assembleFlipResult:@[card2, card1]];
                
                // then look for the third card
                for (SetCard *card3 in self.cards) {
                    
                    //if there is the third card, check for its match score
                    if (!card3.isUnplayable && card3.isFaceUp && (card3 != card1) && (card3 != card2)) {
                        int matchScore = [card1 match:@[card2, card3]];
                        
                        // if there is a match score, all cards are now unplayable
                        if (matchScore) {
                            card1.unplayable = YES;
                            card2.unplayable = YES;
                            card3.unplayable = YES;
                            int score = matchScore * MATCH_BONUS;
                            self.score += score;
                            
                            // create a result
                            self.stylizedFlipResult = [self assembleFlipResult:@[@"match", card3, card2, card1, [NSNumber numberWithInt:(score)]]];
                        } else {
                            // if no score, all cards are turned face down, and a penalty is applied
                            card1.faceUp = NO;
                            card2.faceUp = NO;
                            card3.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            self.stylizedFlipResult = [self assembleFlipResult:@[@"not a match", card3, card2, card1, @(MISMATCH_PENALTY)]];
                        }
                        // break for-loop if the third card is found.
                        break;
                    }
                }
            }
        }
    }
}

#pragma mark -
#pragma mark Getters

-(NSAttributedString *)assembleFlipResult:(NSArray *)cards
{
    NSMutableAttributedString *flipResult = nil;
    if ([cards count] == 1) {
        if ([cards[0] isMemberOfClass:[SetCard class]]) {
            SetCard *card = cards[0];
            flipResult = [[NSMutableAttributedString alloc] initWithString:@"Selected "];
            [flipResult appendAttributedString:card.stylizedContents];
        }
    } else if ([cards count] == 2) {
        if ([cards[0] isMemberOfClass:[SetCard class]] && [cards[1] isMemberOfClass:[SetCard class]]) {
            SetCard *card2 = cards[0];
            SetCard *card1 = cards[1];
            flipResult = [[NSMutableAttributedString alloc] initWithString:@"Selected  and "];
            [flipResult insertAttributedString:card1.stylizedContents atIndex:14];
            [flipResult insertAttributedString:card2.stylizedContents atIndex:9];
        }
    } else if ([cards count] == 5) {
        SetCard *card3 = cards[1];
        SetCard *card2 = cards[2];
        SetCard *card1 = cards[3];
        NSNumber *score = cards[4];
        
        if ([cards[0] isEqualToString:@"match"]) {
            flipResult = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@", , and  are a set!\nGained %@ points!", score]];
            [flipResult insertAttributedString:card1.stylizedContents atIndex:8];
            [flipResult insertAttributedString:card2.stylizedContents atIndex:2];
            [flipResult insertAttributedString:card3.stylizedContents atIndex:0];
            
        } else if ([cards[0] isEqualToString:@"not a match"]) {
            flipResult = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@", , and  are not a set!\nLost %@ points :(", score]];
            [flipResult insertAttributedString:card1.stylizedContents atIndex:8];
            [flipResult insertAttributedString:card2.stylizedContents atIndex:2];
            [flipResult insertAttributedString:card3.stylizedContents atIndex:0];
        }
    }
    return [flipResult copy];
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(NSAttributedString *)stylizedFlipResult
{
    if (!_stylizedFlipResult) {
        _stylizedFlipResult = [[NSMutableAttributedString alloc] init];
    }
    return _stylizedFlipResult;
}

@end
