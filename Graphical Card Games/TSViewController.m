//
//  TSViewController.m
//  Graphical Card Games
//
//  Created by Karl Lee on 2013-05-03.
//  Copyright (c) 2013 Twilight Soft. All rights reserved.
//

#import "TSViewController.h"
#import "TSPlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface TSViewController ()
@property (weak, nonatomic) IBOutlet TSPlayingCardView *playingCardView;
@property (strong, nonatomic) Deck *deck;

@end

@implementation TSViewController

- (Deck *)deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void)setPlayingCardView:(TSPlayingCardView *)playingCardView
{
    _playingCardView = playingCardView;
    [self drawRandomPlayingCard];
}

- (void)drawRandomPlayingCard
{
    Card *card = [self.deck drawRandomCard];
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        self.playingCardView.rank = playingCard.rank;
        self.playingCardView.suit = playingCard.suit;
    }
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [UIView transitionWithView:self.playingCardView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        if (!self.playingCardView.isFaceUp) [self drawRandomPlayingCard];
                        self.playingCardView.faceUp = !self.playingCardView.faceUp;
                    }
                    completion:NULL];
}

@end
