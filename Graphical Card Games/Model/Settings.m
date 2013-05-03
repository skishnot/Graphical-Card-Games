//
//  Settings.m
//  Card Games
//
//  Created by Karl Lee on 2013-04-23.
//  Copyright (c) 2013 Karl Lee. All rights reserved.
//

#import "Settings.h"

@implementation Settings

#define ALL_SETTINGS_KEY @"GameSetting_All"
#define CARD_BACK_KEY @"CardBackImage"
#define BLUE @"BlueCardBack.png"
#define RED @"RedCardBack.png"
#define YUGIOH @"YugiohCardBack.jpg"

- (id)init
{
    self = [super init];
    if (self) {
        _cardBack = @"BlueCardBack.png";
    }
    return self;
}

+ (NSString *)currentBackground
{
    NSString *backgroundName = @"";
    
    backgroundName = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_SETTINGS_KEY] objectForKey:CARD_BACK_KEY];
    
    return backgroundName;
}

// convenience init
-(id)initFromPropertyList:(id)plist
{
    self = [self init];
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _cardBack = resultDictionary[CARD_BACK_KEY];
        }
    }
    return self;
}

-(void)synchronize
{
    NSMutableDictionary *defaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_SETTINGS_KEY] mutableCopy];
    if (!defaults) defaults = [[NSMutableDictionary alloc] init];
    defaults[[self.cardBack description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:[self asPropertyList] forKey:ALL_SETTINGS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(id)asPropertyList
{
    return @{ CARD_BACK_KEY: self.cardBack};
}

-(void)setCardBack:(NSString *)cardBack
{
    _cardBack = cardBack;
    [self synchronize];
}

@end
