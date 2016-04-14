//
//  TableScrollViewController.m
//  CMCyclicScrollDemo
//
//  Created by PRO on 16/2/21.
//  Copyright © 2016年 desn. All rights reserved.
//

#import "TableScrollViewController.h"
#import "MXScrollView.h"

static NSString *const MXScrollCellIdentifer = @"CMCyclicScrollTableViewCell";
static CGFloat   const MXScrollViewHeight = 175.0f;

@interface TableScrollViewController () <UITableViewDataSource, UITableViewDelegate, MXScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MXScrollView *scroll;

@end

@implementation TableScrollViewController

- (void)viewWillAppear:(BOOL)animated {
    //    [_scroll invalidateTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_scroll invalidateTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initBaseLayout];
    //    [self.navigationController.navigationBar setHidden:YES];
}

- (void)initBaseLayout {
    self.title = @"向下拉";
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor lightGrayColor]
                                                                      }];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MXScrollCellIdentifer];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    
    //CMCyclickScroll
    _scroll = [[MXScrollView alloc] initWithFrame:CGRectMake(0,
                                                             0,
                                                             CGRectGetWidth(self.view.bounds),
                                                             MXScrollViewHeight)
                                    rootTableView:_tableView];
    _scroll.animotionDirection = kMXTransitionDirectionRandom;
    _scroll.animotionType = kMXTransitionRandom;
    _scroll.delegate = self;
    _scroll.images =  @[
                        [UIImage imageNamed:@"picture_one"],
                        [UIImage imageNamed:@"picture_two"],
                        [UIImage imageNamed:@"picture_three"],
                        @"http://pic31.nipic.com/20130624/8821914_104949466000_2.jpg"
                        ];
    _scroll.scrollIntervalTime = 6;
    [_scroll setTapImageHandle:^(NSInteger index) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:[NSString stringWithFormat:@"你点击了第%ld张图片", index]
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"ok", nil];
        [alert show];
    }];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
#warning 重要，想拉伸必须实现此方法
    [_scroll stretchingImage];
}

#pragma mark - MXScrollVeiwDelegate
- (UIView *)MXScrollView:(MXScrollView *)mxScrollView viewForImageLeftAccessoryViewAtIndex:(NSInteger)index {
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 50, 20)];
    leftLabel.backgroundColor = [UIColor clearColor];
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.text = [NSString stringWithFormat:@"第%ld页", index];
    return leftLabel;
}

- (UIView *)MXScrollView:(MXScrollView *)mxScrollView viewForImageRightAccessoryViewAtIndex:(NSInteger)index {
    UIImageView *rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) - 40, 140, 30, 30)];
    rightImage.image = [UIImage imageNamed:@"car"];
    return rightImage;
}

- (UIViewAutoresizing)MXScrollView:(MXScrollView *)mxScrollView rightAccessoryViewAutoresizingMaskAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return UIViewAutoresizingFlexibleBottomMargin;
            break;
        case 1:
            return UIViewAutoresizingFlexibleHeight;
            break;
        default:
            return UIViewAutoresizingFlexibleTopMargin;
            break;
    }
}

#pragma mark - tabelView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MXScrollCellIdentifer forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
