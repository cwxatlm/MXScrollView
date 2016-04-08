//
//  AnimationViewController.m
//  MXScrollViewDemo
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import "AnimationViewController.h"
#import "MXScrollView.h"

#define Screen_Rect [UIScreen mainScreen].bounds

@interface AnimationViewController ()

@property (nonatomic, strong) NSMutableArray *scrollViews;

@end

@implementation AnimationViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_scrollViews enumerateObjectsUsingBlock:^(MXImageScrollView *scroll,
                                               NSUInteger idx,
                                               BOOL * _Nonnull stop) {
        [scroll invalidateTimer];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollViews = [NSMutableArray array];
    
    CGFloat scrollViewWidth = 150;
    CGFloat scrollViewHeight = 120;
    
    CGFloat x_gap = (CGRectGetWidth(Screen_Rect) - scrollViewWidth * 2) / 3;
    CGFloat y_gap = x_gap;
    for (int i=0; i<4; i++) {
        CGFloat scrollViewX = (scrollViewWidth + x_gap) * (i % 2) + x_gap;
        CGFloat scrollViewY = (scrollViewHeight + y_gap) * (i / 2) + y_gap + 64;
        MXImageScrollView *scroll = [[MXImageScrollView alloc] initWithFrame:CGRectMake(scrollViewX,
                                                                                        scrollViewY,
                                                                                        scrollViewWidth,
                                                                                        scrollViewHeight)];
        scroll.showAnimotion = YES;
        scroll.animotionType = kMXTransitionRandom;
        scroll.animotionDirection = kMXTransitionDirectionRandom;
        scroll.images = @[[UIImage imageNamed:@"picture_1"],
                           [UIImage imageNamed:@"picture_2"],
                           [UIImage imageNamed:@"picture_3"]];
        [self.view addSubview:scroll];
        [_scrollViews addObject:scroll];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
