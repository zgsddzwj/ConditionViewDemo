//
//  ViewController.m
//  ConditionView
//
//  Created by AdwardGreen on 2017/12/28.
//  Copyright © 2017年 WangJian. All rights reserved.
//

#import "ViewController.h"
#import "YX_ConditionsView.h"

@interface ViewController ()
@property (nonatomic, strong) YX_ConditionsView *conditionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak typeof (self)weakSelf = self;
    _conditionView = [[YX_ConditionsView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 20) titles:@[@"奥迪",@"哈弗"] selectedHandler:^(NSUInteger index, NSString *title) {
        [weakSelf.conditionView insertLabelWithTitle:@"宝马" atIndex:index animated:YES];

    }];
    [self.view addSubview:_conditionView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
