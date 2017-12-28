//
//  YX_ConditionFlowLayout.m
//  StraightRental
//
//  Created by AdwardGreen on 2017/12/28.
//

#import "YX_ConditionFlowLayout.h"
#import "YX_ConditionFlowConfig.h"

typedef struct currentOrigin {
    CGFloat     lineX;
    NSInteger   lineNumber;
}currentOrigin;

@implementation YX_ConditionFlowLayout

{
    UIEdgeInsets    contentInsets;
    CGFloat         itemHeight;
    CGFloat         itemSpace;
    CGFloat         lineSpace;
    CGFloat         itemMargin;
    UIFont          *titleFont;
    NSInteger       itemCount;
    currentOrigin   orgin;
}

- (void)prepareLayout {
    [super prepareLayout];
    YX_ConditionFlowConfig *config = [YX_ConditionFlowConfig sharedConfig];
    contentInsets = config.contentInsets;
    titleFont = config.textFont;
    lineSpace = config.lineSpace;
    itemHeight = config.itemHeight;
    itemSpace = config.itemSpace;
    itemCount = [self.collectionView numberOfItemsInSection:0];
    itemMargin = config.textMargin;
    orgin.lineNumber = 0;
    orgin.lineX = contentInsets.left;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    for (NSInteger i = 0; i<attributesArray.count; i++) {
        UICollectionViewLayoutAttributes *att = attributesArray[i];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        NSString *title = [self.dataSource titleForLabelAtIndexPath:indexPath];
        CGSize size = [self sizeWithTitle:title font:titleFont];
        CGFloat itemOrginX = orgin.lineX;
        CGFloat itemOrginY = orgin.lineNumber*(itemHeight+lineSpace) + contentInsets.top;
        CGFloat itemWidth = size.width+itemMargin;
        if (itemWidth > CGRectGetWidth(self.collectionView.frame)-(contentInsets.left+contentInsets.right)) {
            itemWidth = CGRectGetWidth(self.collectionView.frame)-(contentInsets.left+contentInsets.right);
        }
        att.frame = CGRectMake(itemOrginX, itemOrginY, itemWidth, itemHeight);
        orgin.lineX += itemWidth+itemSpace;
        if (i < attributesArray.count-1) {
            NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:i+1 inSection:0];
            NSString *nextTitle = [self.dataSource titleForLabelAtIndexPath:nextIndexPath];
            CGSize nextSize = [self sizeWithTitle:nextTitle font:titleFont];
            if (nextSize.width+itemMargin > CGRectGetWidth(self.collectionView.frame)-contentInsets.right-orgin.lineX) {
                orgin.lineNumber ++;
                orgin.lineX = contentInsets.left;
            }
        }
        else {
            [self.delegate layoutFinishWithNumberOfline:orgin.lineNumber+1];
        }
    }
    return attributesArray;
}

- (CGSize)sizeWithTitle:(NSString *)title font:(UIFont *)font {
    CGRect rect = [title boundingRectWithSize:CGSizeMake(1000, itemHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}

@end
