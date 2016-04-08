//
//  VerticalUseViewController.m
//  MXScrollViewDemo
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import "VerticalUseViewController.h"
#import "MXScrollView.h"

#define Screen_Rect [UIScreen mainScreen].bounds

@interface VerticalUseViewController ()
{
    MXImageScrollView *scroll1;
    MXImageScrollView *scroll2;
}
@end

@implementation VerticalUseViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [scroll1 invalidateTimer];
    [scroll2 invalidateTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat scrollViewHeight = (CGRectGetHeight(Screen_Rect) - 64 - 150) / 2;
    CGFloat scrollViewWidth = CGRectGetWidth(Screen_Rect) - 60;
    
    scroll1 = [[MXImageScrollView alloc] initWithFrame:CGRectMake(30,
                                                                 50 + 64,
                                                                 scrollViewWidth,
                                                                 scrollViewHeight)];
    scroll1.scrollDirection = kMXScrollViewDirectionVertical;
    scroll1.pageControlPosition = kMXPageControlPositionLeft;
    scroll1.images = @[[UIImage imageNamed:@"picture_1"],
                      [UIImage imageNamed:@"picture_2"],
                       [UIImage imageNamed:@"picture_3"]];
    [self.view addSubview:scroll1];
    
    
    scroll2 = [[MXImageScrollView alloc] initWithFrame:CGRectMake(30,
                                                                  CGRectGetMaxY(scroll1.frame) + 50,
                                                                  scrollViewWidth,
                                                                  scrollViewHeight)];
    scroll2.scrollDirection = kMXScrollViewDirectionVertical;
    scroll2.verticalDirection = kMXVerticalDirectionFromBottom;
    scroll2.images = @[[UIImage imageNamed:@"picture_1"],
                       [UIImage imageNamed:@"picture_2"],
                       [UIImage imageNamed:@"picture_3"]];
    
    [self.view addSubview:scroll2];
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
