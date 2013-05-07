//
//  TSSetCardGameViewController.m
//  Graphical Card Games
//
//  Created by Karl Lee on 2013-05-06.
//  Copyright (c) 2013 Twilight Soft. All rights reserved.
//

#import "TSSetCardGameViewController.h"
#import "TSSetCardCollectionViewCell.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardGame.h"

@interface TSSetCardGameViewController()

@property (strong, nonatomic) CardGame *game;

@end

@implementation TSSetCardGameViewController

@synthesize game = _game;

- (CardGame *)game
{
    if (!_game) _game = [[SetCardGame alloc] initWithCardCount:self.startingCardCount
                                                  usingDeck:[self createDeck]];
    return _game;
}

- (NSUInteger)startingCardCount
{
    return 12;
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[TSSetCardCollectionViewCell class]]) {
        TSSetCardView *setCardView = ((TSSetCardCollectionViewCell *)cell).setCardView;
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)card;
            setCardView.symbol = setCard.symbol;
            setCardView.colour = setCard.colour;
            setCardView.number = setCard.number;
            setCardView.shading = setCard.shading;
            setCardView.stylizedContents = setCard.stylizedContents;
            setCardView.alpha = setCard.isFaceUp ? UNPLAYABLE_CARD_ALPHA : PLAYABLE_CARD_ALPHA;
//            setCardView.alpha = setCard.isUnplayable ? UNPLAYABLE_CARD_ALPHA : PLAYABLE_CARD_ALPHA;
        }
    }
}

@end
