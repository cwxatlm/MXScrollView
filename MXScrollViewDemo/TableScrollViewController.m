//
//  TableScrollViewController.m
//  CMCyclicScrollDemo
//
//  Created by PRO on 16/2/21.
//  Copyright © 2016年 desn. All rights reserved.
//

#import "TableScrollViewController.h"
#import "MXScrollView.h"

static NSString *const CMCyclicScrollIdentifier = @"CMCyclicScrollTableViewCell";

@interface TableScrollViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MXScrollView *scroll;

@end

@implementation TableScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initBaseLayout];
}

- (void)initBaseLayout {
    self.title = @"向下拉";
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor lightGrayColor]
                                                                      }];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CMCyclicScrollIdentifier];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    
    //CMCyclickScroll
    _scroll = [[MXScrollView alloc] initWithRootTableView:_tableView height:150];
    _scroll.animotionDirection = kCMTransitionDirectionRandom;
    _scroll.animotionType = kCMTransitionRandom;
    _scroll.images = @[
                       [UIImage imageNamed:@"picture_one"],
                       [UIImage imageNamed:@"picture_two"],
                       [UIImage imageNamed:@"picture_three"],
                       @"http://pic31.nipic.com/20130624/8821914_104949466000_2.jpg"
                       ];
    
    [_scroll setTapImageHandle:^(NSInteger index) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你点击了第%ld张图片", index] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alert show];
    }];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
#warning 重要，想拉伸必须实现此方法
    [_scroll stretchingImage];
}

#pragma mark - tabelView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMCyclicScrollIdentifier forIndexPath:indexPath];
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
