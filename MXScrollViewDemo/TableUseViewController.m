//
//  TbaleUseViewController.m
//  MXScrollViewDemo
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import "TableUseViewController.h"
#import "MXScrollView.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
static CGFloat const scrollViewHeight = 220;

static NSString *const tableViewCellIdentifer = @"tableViewCellIdentifer";

@interface TableUseViewController () <UITableViewDelegate, UITableViewDataSource, MXScrollViewDelegate>
{
    MXImageScrollView *scroll;
}
@end

@implementation TableUseViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [scroll invalidateTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class]
      forCellReuseIdentifier:tableViewCellIdentifer];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    
    scroll = [[MXImageScrollView alloc] initWithFrame:CGRectMake(0,
                                                                 0,
                                                                 Screen_Width,
                                                                 scrollViewHeight)
                                        rootTableView:tableView];
    scroll.delegate = self;
    scroll.images = @[[UIImage imageNamed:@"picture_1"],
                      [UIImage imageNamed:@"picture_2"],
                      [UIImage imageNamed:@"picture_3"]];

}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
#warning 想拉伸必须实现此方法
    [scroll stretchingSubviews];
}

#pragma mark - MXScrollView delegate
- (UIView *)MXScrollView:(MXImageScrollView *)mxScrollView viewForLeftAccessoryViewAtIndex:(NSInteger)index {
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,
                                                                               scrollViewHeight - 40,
                                                                               30,
                                                                               30)];
    leftImageView.image = [UIImage imageNamed:@"house"];
    return leftImageView;
}

- (UIView *)MXScrollView:(MXImageScrollView *)mxScrollView viewForRightAccessoryViewAtIndex:(NSInteger)index {
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width - 40,
                                                                                scrollViewHeight - 40,
                                                                                30,
                                                                                30)];
    rightImageView.image = [UIImage imageNamed:@"island"];
    return rightImageView;
}

- (UIViewAutoresizing)MXScrollView:(MXImageScrollView *)mxScrollView leftAccessoryViewAutoresizingMaskAtIndex:(NSInteger)index {
    return UIViewAutoresizingFlexibleTopMargin;
}

- (UIViewAutoresizing)MXScrollView:(MXImageScrollView *)mxScrollView rightAccessoryViewAutoresizingMaskAtIndex:(NSInteger)index {
    return UIViewAutoresizingFlexibleTopMargin;
}

#pragma mark - tableVeiw delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifer
                                                            forIndexPath:indexPath];
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
