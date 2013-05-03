//
//  Card.h
//  Matchismo
//
//  Created by Karl Lee on 2013-02-22.
//  Copyright (c) 2013 Karl Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
