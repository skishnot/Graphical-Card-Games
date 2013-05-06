//
//  TSPlayingCardGameViewController.m
//  Graphical Card Games
//
//  Created by Karl Lee on 2013-05-04.
//  Copyright (c) 2013 Twilight Soft. All rights reserved.
//

#import "TSPlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "TSPlayingCardCollectionViewCell.h"

@implementation TSPlayingCardGameViewController

- (NSUInteger)startingCardCount
{
    return 22;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[TSPlayingCardCollectionViewCell class]]) {
        TSPlayingCardView *playingCardView = ((TSPlayingCardCollectionViewCell *)cell).playingCardView;
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            playingCardView.faceUp = playingCard.isFaceUp;
            playingCardView.alpha = playingCard.isUnplayable ? UNPLAYABLE_CARD_ALPHA : PLAYABLE_CARD_ALPHA;
        }
    }
}

@end
