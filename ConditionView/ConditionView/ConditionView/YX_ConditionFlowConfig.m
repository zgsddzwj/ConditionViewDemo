//
//  YX_ConditionFlowConfig.m
//  StraightRental
//
//  Created by AdwardGreen on 2017/12/28.
//

#import "YX_ConditionFlowConfig.h"

@implementation YX_ConditionFlowConfig

+(YX_ConditionFlowConfig *)sharedConfig
{
    static YX_ConditionFlowConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [YX_ConditionFlowConfig new];
    });
    return config;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentInsets = UIEdgeInsetsMake(10, 10, 10, 2);
        self.lineSpace = 10;
        self.itemHeight = 25;
        self.itemSpace = 10;
        self.itemCornerRaius = 3;
        self.itemColor = [UIColor orangeColor];
        self.textMargin = 20;
        self.textColor = [UIColor whiteColor];
        self.textFont = [UIFont systemFontOfSize:15];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

@end
