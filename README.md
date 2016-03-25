# MXScrollView

The use of a simple with the effects of the rolling cycle view
-----
一款易用的可拉伸的自动循环滚动视图 集成简单易懂 自定义性强
-----


![demo](Pictures/demo1GIF.gif)
![demo](Pictures/demo2GIF.gif)

版本1.1 
----
  1.2 版本,大部分代码重构,现在看上去更舒服,功能也更强大,对用旧版本的朋友致歉,因为有些地方没有对旧版本进行兼容.


使用  How to Use it
=====

CocoaPods
---
你可以使用cocapods导入  pod 'MXScrollView'   
you can use it in cocoapods
手动导入工程 
add it in you project
#import "MXScroll.h"

![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

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
_scroll.pageControlPosition = kMXPageControlPositionCenter; //更改pageControl显示的位置
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

delegate
------
```

_scroll.delegate = self;

//delegate method  给图片增加副视图
- (UIView *)MXScrollView:(MXScrollView *)mxScrollView viewForImageLeftAccessoryViewAtIndex:(NSInteger)index {
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 50, 20)];
    leftLabel.backgroundColor = [UIColor clearColor];
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.text = [NSString stringWithFormat:@"第%ld页", index];
    return leftLabel;
}

//视图拉伸效果
- (UIViewAutoresizing)MXScrollView:(MXScrollView *)mxScrollView leftAccessoryViewAutoresizingMaskAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return UIViewAutoresizingFlexibleBottomMargin;
            break;
        default:
            return UIViewAutoresizingFlexibleTopMargin;
            break;
    }
}


```

更多用法请参考Demo    more example read in Demo
