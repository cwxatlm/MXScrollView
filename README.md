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

## Installation

### From CocoaPods

你可以使用cocapods导入  you can use it in cocoapods
```
pod 'MXScrollView'   
```

### Carthage 

[Carthage](https://github.com/Carthage/Carthage) 也是一个很好的管理三方框架的工具

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:
你可以在使用[Homebrew](http://brew.sh/ 来安装Carthage   安装完homebrew后执行下面命令

```bash
$ brew update
$ brew install carthage
```

在你的工程里创建一个`Cartfile`文件 ,并在里面写上下面这句话

```ogdl
git "https://github.com/cwxatlm/MXScrollView.git"
```

在终端里执行`carthage update`
安装好后只需要在对应 Target 中的 Build Setting 中的 Framework Search Path 项加入以下路径
`$(SRCROOT)/Carthage/Build/iOS`

### Manually  手动导入
* Drag the `MXScrollView` folder into your project.  把`MXScrollView`文件夹拖入工程
* `Targets->Build Phases->Copy Bundle Resources`.
* `#imprort "MXScroll.h"`

有两种使用方式  you can use it in two ways
### 1.像普通控件一样使用它  use it looks like normal View


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

### 2.加载在tableView上   load it in tableView

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

### delegate

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

### 更多用法请参考Demo    more example read in Demo
