//
//  YX_ConditionFlowConfig.h
//  StraightRental
//
//  Created by AdwardGreen on 2017/12/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YX_ConditionFlowConfig : NSObject

+ (YX_ConditionFlowConfig *)sharedConfig;

@property (nonatomic) UIEdgeInsets  contentInsets;
@property (nonatomic) CGFloat       textMargin;
@property (nonatomic) CGFloat       lineSpace;
@property (nonatomic) CGFloat       itemHeight;
@property (nonatomic) CGFloat       itemSpace;
@property (nonatomic) CGFloat       itemCornerRaius;
@property (nonatomic) UIColor       *itemColor;
@property (nonatomic) UIColor       *textColor;
@property (nonatomic) UIFont        *textFont;
@property (nonatomic) UIColor       *backgroundColor;

@end
