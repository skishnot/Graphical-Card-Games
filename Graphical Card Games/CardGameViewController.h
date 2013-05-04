//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Karl Lee on 2013-02-22.
//  Copyright (c) 2013 Karl Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController
@property (nonatomic) NSUInteger startingCardCount; // abstract

- (Deck *)createDeck; // abstract
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)Card; // abstract

@end
