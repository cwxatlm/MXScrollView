//
//  MXImageScrollView.h
//  MXScrollViewDemo
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import "MXBaseScrollView.h"

@interface MXImageScrollView : MXBaseScrollView

@property (nonatomic, strong) NSArray *images;//传入的图片数组(支持传入图片或图片地址)

/**点击回调*/
@property (nonatomic, copy) void (^tapImageHandle)(NSInteger index);

/**
 *  普通模式创建一个MXScrollView
 *
 *  @param frame 位置
 *
 *  @return 实例化对象
 */
- (instancetype)initWithFrame:(CGRect)frame;


/**
 *  TableView模式(无导航栏需设置hasNavigationBar为NO)
 *
 *  @param frame         位置
 *  @param rootTableView 根TableView
 *
 *  @return 实例化对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                rootTableView:(UITableView *)rootTableView;

/**
 *  拉伸图片 加载在tableView上面时，须在scrollViewDidScroll代理中实现本方法方可拉伸图片
 */
- (void)stretchingSubviews;

/**
 *  释放定时器,可以写在viewWillDisappear里
 */
- (void)invalidateTimer;

@end
