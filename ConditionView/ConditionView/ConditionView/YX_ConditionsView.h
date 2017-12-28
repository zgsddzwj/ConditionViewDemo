//
//  YX_ConditionsView.h
//  StraightRental
//
//  Created by AdwardGreen on 2017/12/28.
//

#import <UIKit/UIKit.h>

typedef void(^YXSelectedConditionBlock)(NSUInteger index,NSString *title);

@interface YX_ConditionsView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
              selectedHandler:(YXSelectedConditionBlock)handler;

- (void)insertLabelWithTitle:(NSString *)title
                     atIndex:(NSUInteger)index
                    animated:(BOOL)animated;

- (void)insertLabelsWithTitles:(NSArray *)titles
                     atIndexes:(NSIndexSet *)indexes
                      animated:(BOOL)animated;

- (void)deleteLabelAtIndex:(NSUInteger)index
                  animated:(BOOL)animated;

- (void)deleteLabelsAtIndexes:(NSIndexSet *)indexes
                     animated:(BOOL)animated;

- (void)reloadAllWithTitles:(NSArray *)titles;


@end

@interface YX_ConditionCell : UICollectionViewCell

- (void)configCellWithTitle:(NSString *)title;

@end
