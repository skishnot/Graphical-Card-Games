//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Karl Lee on 2013-02-22.
//  Copyright (c) 2013 Karl Lee. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardGame.h"

@interface CardGameViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipcount;
@property (strong, nonatomic) CardGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipResultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameLogicController;
@property (weak, nonatomic) IBOutlet UISlider *labelSlider;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

@end

@implementation CardGameViewController

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    // in the assignment, I actually want to ask how many cards are currently in play
    return self.startingCardCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)Card
{
    // abstract
}

- (CardGame *)game
{
    if (!_game) _game = [[CardGame alloc] initWithCardCount:self.startingCardCount
                                                 usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck { return nil; } // abstract

- (void)updateUI
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    // Display flip result
    self.flipResultLabel.alpha = 1.0;
    self.flipResultLabel.text = [self.game flipResult];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)setFlipcount:(int)flipcount
{
    _flipcount = flipcount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipcount];
    NSLog(@"flip count updated to %d", self.flipcount);
}

- (IBAction)flipCard:(UIGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        self.flipcount++;
        self.gameLogicController.enabled = NO;
        [self updateUI];
    }
}

- (IBAction)redeal {
    self.game = nil;
    [self.game reset];
    self.flipcount = 0;
    self.gameLogicController.enabled = YES;
    [self updateUI];
}

- (IBAction)viewHistory:(UISlider *)sender {
    self.flipResultLabel.text = [self.game.flipHistory objectAtIndex:(int)sender.value];
    self.flipResultLabel.alpha = 0.3;
}

-(void)updateGameLogicSetting
{
    if (self.gameLogicController.selectedSegmentIndex == 0) {
        self.game.match3mode = NO;
    } else {
        self.game.match3mode = YES;
    }
}

- (IBAction)changeGameLogicSetting:(UISegmentedControl *)sender {
    [self updateGameLogicSetting];
}

@end
