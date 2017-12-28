//
//  YX_ConditionFlowLayout.h
//  StraightRental
//
//  Created by AdwardGreen on 2017/12/28.
//

#import <UIKit/UIKit.h>

@protocol YX_ConditionFlowLayoutDelegate <NSObject>

@optional

- (void)layoutFinishWithNumberOfline:(NSInteger)number;

@end

@protocol YX_ConditionFlowLayoutDataSource <NSObject>

- (NSString *)titleForLabelAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface YX_ConditionFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<YX_ConditionFlowLayoutDelegate> delegate;
@property (nonatomic, weak) id<YX_ConditionFlowLayoutDataSource> dataSource;

@end
