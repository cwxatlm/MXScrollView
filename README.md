# MXScrollView

The use of a simple with the effects of the rolling cycle view
-----
一款易用的可拉伸的自动循环滚动视图 集成简单易懂 自定义性强
-----


![demo](Pictures/demo1GIF.gif)
![demo](Pictures/demo2GIF.gif)

版本1.1 
----
  1.1 版本,MXScrollView迎来了新生,大部分代码重构,现在看上去更舒服,功能也更强大,那么问题来了...如果你之前用了我这个库,那么一更新你就发现会报错!这个...如果你真的用了又更新了...那么,不好意思,不过改起来也简单,而且新版功能更强!欢迎体验.


使用  How to Use it
=====

CocoaPods
---
你可以使用cocapods导入  pod 'MXScrollView'   
you can use it in cocoapods
手动导入工程 
add it in you project
#import "MXScrollView.h"


有两种使用方式  you can use it in two ways
1.像普通控件一样使用它  use it looks like normal View
--------

####Objective-C
```objective-c
MXScrollView *scroll = [[MXScrollView alloc] initWithFrame:CGRectMake(x, y, scrollWidth, scrollHeight)];
        //数组支持传入image或imageUrl       support image or imageUrl
scroll.images =  @[
                  [UIImage imageNamed:@"picture_one"],
                  [UIImage imageNamed:@"picture_two"],
                  [UIImage imageNamed:@"picture_three"],
                  @"http://pic31.nipic.com/20130624/8821914_104949466000_2.jpg"
                  ];
scroll.animotionType = kCMTransitionRandom; //支持多特效 support serveral type
scroll.animotionDirection = kCMTransitionDirectionRandom; //支持多方向 support serveral direction
[self.view addSubview:scroll];

[scroll setTapImageHandle:^(NSInteger index) {
           //支持点击事件  support tap
        }];
```

2.加载在tableView上   load it in tableView
------
此时必须写为全局变量

####Objective-C
```objective-c
_scroll = [[MXScrollView alloc] initWithRootTableView:_tableView];
_scroll.animotionDirection = kCMTransitionDirectionRandom;
_scroll.animotionType = kCMTransitionRandom;
_scroll.images = @[
                  [UIImage imageNamed:@"picture_one"],
                  [UIImage imageNamed:@"picture_two"],
                  [UIImage imageNamed:@"picture_three"],
                  @"http://pic31.nipic.com/20130624/8821914_104949466000_2.jpg"
                  ];

[_scroll setTapImageHandle:^(NSInteger index) {
        //tap
    }];
    
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
#warning 重要，想拉伸必须实现此方法   must implement this method
    [_scroll stretchingImage];
}
    
```
