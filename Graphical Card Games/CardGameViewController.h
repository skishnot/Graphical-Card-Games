//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Karl Lee on 2013-02-22.
//  Copyright (c) 2013 Karl Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardGame.h"

@interface CardGameViewController : UIViewController
@property (nonatomic) NSUInteger startingCardCount; // abstract
@property (strong, nonatomic, readonly) CardGame *game;

- (Deck *)createDeck; // abstract
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)Card; // abstract

@end
