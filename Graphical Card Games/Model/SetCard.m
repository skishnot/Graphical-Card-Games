//
//  SetCard.m
//  Card Games
//
//  Created by Karl Lee on 2013-04-17.
//  Copyright (c) 2013 Karl Lee. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()

@property (nonatomic) NSDictionary *attributes;


@end

@implementation SetCard
@synthesize colour = _colour, symbol = _symbol, shading = _shading, number = _number;

-(NSString *)contents
{
    NSString *contents = [[NSString alloc] init];
    for (int i = 1; i <= self.number; i++) {
        contents = [contents stringByAppendingString:self.symbol];
    }
    return contents;
}

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    NSUInteger number = self.number;
    NSString *shading = self.shading;
    UIColor *colour = self.colour;
    NSString *symbol = self.symbol;
    
    // check for number; other two cards have to either be the same or all different
    if ([otherCards count] == 2) {
        SetCard *card1 = (SetCard *)otherCards[0];
        SetCard *card2 = (SetCard *)otherCards[1];
        
        if (((number == card1.number) && (number == card2.number)) ||
            ((number != card1.number) && (number != card2.number) && (card1.number != card2.number))) {
            if (([card1.shading isEqualToString:shading] && [card2.shading isEqualToString:shading]) ||
                (![card1.shading isEqualToString:shading] && ![card2.shading isEqualToString:shading] && ![card2.shading isEqualToString:card1.shading])) {
                if (([card1.symbol isEqualToString:symbol] && [card2.symbol isEqualToString:symbol]) ||
                    (![card1.symbol isEqualToString:symbol] && ![card2.symbol isEqualToString:symbol] && ![card2.symbol isEqualToString:card1.symbol])) {
                    if (((card1.colour == colour) && (card2.colour == colour)) ||
                        ((card1.colour != colour) && (card2.colour != colour) && (card2.colour != card1.colour))) {
                        // match found
                        score = 100;
                    }
                }
            }
        }
    }
    
    return score;
}

#pragma mark -
#pragma mark getters

-(NSAttributedString *)stylizedContents
{
    if (!_stylizedContents) {
        _stylizedContents = [[NSAttributedString alloc] initWithString:self.contents
                                                          attributes:self.attributes];
    }
    return _stylizedContents;
}

-(NSDictionary *)attributes
{
    if (!_attributes) {
        NSDictionary *listOfAttributes = @{@"solid": @{NSStrokeWidthAttributeName: @-5,
                                                       NSForegroundColorAttributeName: self.colour},
                                           @"striped": @{NSStrokeWidthAttributeName: @-5,
                                                         NSForegroundColorAttributeName: [self.colour colorWithAlphaComponent:0.2]},
                                           @"open": @{NSStrokeWidthAttributeName: @5,
                                                      NSForegroundColorAttributeName: self.colour}};
        
        NSDictionary *shadingAttribute = [listOfAttributes objectForKey:self.shading];
        NSMutableDictionary *combinedAttributes = [[NSMutableDictionary alloc] initWithDictionary:shadingAttribute];
        _attributes = [combinedAttributes copy];
    }
    
    return _attributes;
}

#pragma mark -
#pragma mark setters
-(void)setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}
-(void)setColour:(UIColor *)colour {
    if ([[SetCard validColours] containsObject:colour]) {
        _colour = colour;
    }
}
-(void)setShading:(NSString *)shading {
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}
-(void)setNumber:(NSUInteger)number {
    if ((number <= 3) && (number >= 1)) {
        _number = number;
    }
}

#pragma mark -
#pragma mark class methods
+(NSArray *)validSymbols {
    NSArray *array = @[@"▲", @"●", @"■"];
    return array;
}
+(NSArray *)validShadings {
    NSArray *validShadings = @[@"solid", @"striped", @"open"];
    return validShadings;
}
+(NSArray *)validColours {
    NSArray *validColours = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
    return validColours;
}
+(NSUInteger)maxNumber {
    return 3;
}

@end
