//
//  EasyUseViewController.m
//  MXScrollViewDemo
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import "EasyUseViewController.h"
#import "MXScrollView.h"

#define Screen_Width [UIScreen mainScreen].bounds
static CGFloat const scrollViewWidth = 300;
static CGFloat const scrollViewHeight = 200;

@interface EasyUseViewController ()
{
    MXImageScrollView *scroll;
}
@end

@implementation EasyUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    scroll = [[MXImageScrollView alloc] initWithFrame:CGRectMake((CGRectGetWidth(Screen_Width) - scrollViewWidth) / 2,
                                                                 scrollViewHeight,
                                                                 scrollViewWidth,
                                                                 scrollViewHeight)];
    scroll.images = @[[UIImage imageNamed:@"picture_one"],
                      [UIImage imageNamed:@"picture_two"],
                      [UIImage imageNamed:@"picture_three"]];
    [self.view addSubview:scroll];
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
