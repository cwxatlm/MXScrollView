//
//  TbaleUseViewController.m
//  MXScrollViewDemo
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import "TableUseViewController.h"
#import "MXScrollView.h"

#define Screen_Width [UIScreen mainScreen].bounds
static CGFloat const scrollViewWidth = 300;
static CGFloat const scrollViewHeight = 180;

static NSString *const tableViewCellIdentifer = @"tableViewCellIdentifer";

@interface TableUseViewController () <UITableViewDelegate, UITableViewDataSource>
{
    MXImageScrollView *scroll;
}
@end

@implementation TableUseViewController

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
    [self.view addSubview:tableView];
    
    scroll = [[MXImageScrollView alloc] initWithFrame:CGRectMake(0,
                                                                 0,
                                                                 [UIScreen mainScreen].bounds.size.width,
                                                                 scrollViewHeight)
                                        rootTableView:tableView];
    
    scroll.images = @[[UIImage imageNamed:@"picture_1"],
                      [UIImage imageNamed:@"picture_2"],
                      [UIImage imageNamed:@"picture_3"]];

}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scroll stretchingSubviews];
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
