//
//  YX_ConditionsView.m
//  StraightRental
//
//  Created by AdwardGreen on 2017/12/28.
//

#import "YX_ConditionsView.h"
#import "YX_ConditionFlowConfig.h"
#import "YX_ConditionFlowLayout.h"
static NSString *const YX_ConditionCellID = @"YX_ConditionCellID";

@interface YX_ConditionsView()<UICollectionViewDelegate,UICollectionViewDataSource,YX_ConditionFlowLayoutDelegate,YX_ConditionFlowLayoutDataSource>

@property (nonatomic,strong) UICollectionView            *collection;
@property (nonatomic,strong) NSMutableArray              *data;
@property (nonatomic,  copy) YXSelectedConditionBlock    handler;

@end

@implementation YX_ConditionsView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectedHandler:(YXSelectedConditionBlock)handler; {
    self = [super initWithFrame:frame];
    if (!titles.count) {
        return self;
    }
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.data = [titles mutableCopy];
        self.handler = handler;
        [self setup];
    }
    return self;
}

- (void)setup {
    YX_ConditionFlowLayout *layout = [[YX_ConditionFlowLayout alloc]init];
    layout.delegate = self;
    layout.dataSource = self;
    self.collection = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    self.collection.backgroundColor = [YX_ConditionFlowConfig sharedConfig].backgroundColor;
    self.collection.allowsMultipleSelection = YES;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerClass:[YX_ConditionCell class] forCellWithReuseIdentifier:YX_ConditionCellID];
    [self addSubview:self.collection];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YX_ConditionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YX_ConditionCellID forIndexPath:indexPath];
    [cell configCellWithTitle:self.data[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.handler) {
        NSUInteger index = indexPath.item;
        NSString *title = self.data[index];
        self.handler(index,title);
    }
}

- (NSString *)titleForLabelAtIndexPath:(NSIndexPath *)indexPath {
    return self.data[indexPath.item];
}

- (void)layoutFinishWithNumberOfline:(NSInteger)number {
    static NSInteger numberCount;
    if (numberCount == number) {
        return;
    }
    numberCount = number;
    YX_ConditionFlowConfig *config = [YX_ConditionFlowConfig sharedConfig];
    CGFloat h = config.contentInsets.top+config.contentInsets.bottom+config.itemHeight*number+config.lineSpace*(number-1);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, h);
    [UIView animateWithDuration:0.2 animations:^{
        self.collection.frame = self.bounds;
    }];
}


- (void)insertLabelWithTitle:(NSString *)title atIndex:(NSUInteger)index animated:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.data insertObject:title atIndex:index];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionInsert indexPaths:@[indexPath] animated:animated];
}

- (void)insertLabelsWithTitles:(NSArray *)titles atIndexes:(NSIndexSet *)indexes animated:(BOOL)animated {
    NSArray *indexPaths = [self indexPathsWithIndexes:indexes];
    [self.data insertObjects:titles atIndexes:indexes];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionInsert indexPaths:indexPaths animated:animated];
}

- (void)deleteLabelAtIndex:(NSUInteger)index animated:(BOOL)animated {
    [self deleteLabelsAtIndexes:[NSIndexSet indexSetWithIndex:index] animated:animated];
}

- (void)deleteLabelsAtIndexes:(NSIndexSet *)indexes animated:(BOOL)animated {
    NSArray *indexPaths = [self indexPathsWithIndexes:indexes];
    [self.data removeObjectsAtIndexes:indexes];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionDelete indexPaths:indexPaths animated:animated];
}

- (void)reloadAllWithTitles:(NSArray *)titles {
    self.data = [titles mutableCopy];
    [self.collection reloadData];
}

- (void)performBatchUpdatesWithAction:(UICollectionUpdateAction)action indexPaths:(NSArray *)indexPaths animated:(BOOL)animated {
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    [self.collection performBatchUpdates:^{
        switch (action) {
            case UICollectionUpdateActionInsert:
                [self.collection insertItemsAtIndexPaths:indexPaths];
                break;
            case UICollectionUpdateActionDelete:
                [self.collection deleteItemsAtIndexPaths:indexPaths];
            default:
                break;
        }
    } completion:^(BOOL finished) {
        if (!animated) {
            [UIView setAnimationsEnabled:YES];
        }
    }];
}

- (NSArray *)indexPathsWithIndexes:(NSIndexSet *)set {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:set.count];
    [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }];
    return [indexPaths copy];
}


@end

@interface YX_ConditionCell()
@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation YX_ConditionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self configureCell];
    }
    return self;
}

- (void)configureCell;
{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.backgroundColor = [YX_ConditionFlowConfig sharedConfig].itemColor;
    _titleLabel.textColor = [YX_ConditionFlowConfig sharedConfig].textColor;
    _titleLabel.font = [YX_ConditionFlowConfig sharedConfig].textFont;
    _titleLabel.layer.masksToBounds = YES;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    _titleLabel.frame = self.bounds;
}

-(void)configCellWithTitle:(NSString *)title
{
    _titleLabel.text = title;
}

@end
