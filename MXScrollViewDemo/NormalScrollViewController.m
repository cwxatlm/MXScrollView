//
//  NormalScrollViewController.m
//  CMCyclicScrollDemo
//
//  Created by PRO on 16/2/21.
//  Copyright © 2016年 desn. All rights reserved.
//

#import "NormalScrollViewController.h"
#import "MXScroll.h"

static float const scrollWidth  = 150;
static float const scrollHeight = 100;
static int   const scrollCount  = 6;

@interface NormalScrollViewController ()

@end

@implementation NormalScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Normol循环滚动";
    [self initBaseLayout];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[MXScrollView class]]) {
            [((MXScrollView *)obj) invalidateTimer];
        }
    }];
}

- (void)initBaseLayout {
    
    float gap = (CGRectGetWidth([UIScreen mainScreen].bounds) - scrollWidth * 2) / 3.0f;
    for (int i = 0; i < scrollCount; i++) {
        float x = gap + (gap + scrollWidth) * (i % 2);
        float y = gap + (gap + scrollHeight) * (i / 2) + 64;
        
        MXScrollView *scroll = [[MXScrollView alloc] initWithFrame:CGRectMake(x, y, scrollWidth, scrollHeight)];
        scroll.images = @[
                          @"http://pic1.nipic.com/2008-09-19/200891903253318_2.jpg",
                          @"http://pic7.nipic.com/20100516/1263764_003945544701_2.jpg",
                          @"http://pic4.nipic.com/20091117/3376018_110331702620_2.jpg",
                          @"http://pic31.nipic.com/20130624/8821914_104949466000_2.jpg"
                          ];
        scroll.animotionType = kMXTransitionRandom;
        scroll.animotionDirection = kMXTransitionDirectionRandom;
        scroll.pageControlPosition = i % 2 == 0 ? kMXPageControlPositionLeft : kMXPageControlPositionRight;
        scroll.showPageIndicatorBottonLine = i % 2 == 0;
        scroll.showAnimotion = i != 0; //第一张显示无特效(平滑过渡);
        [self.view addSubview:scroll];
        
        [scroll setTapImageHandle:^(NSInteger index) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"🐵🐵🐵" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alert show];
        }];
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
