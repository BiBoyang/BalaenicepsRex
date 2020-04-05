# 从头开始做一个开发助手工具（一）：控件的搭建
## 起因
在开发中，我们往往在准备提测的时候会进行各种性能的检测和bug检测。
那么为什么不能在开发中就去就去检测发现并且解决一些简单的问题呢？我们可不可以做一个工具，来进行性能的检测和app信息的展示，方便我们去进行测试和修复呢？
带着这个想法，我准备在原有开发小工具的基础上，整合出一个debug阶段的开发助手（并且可以在整合和开发的过程中，方便自己整合之前的知识）。

类似的工具有[FBMemoryProfiler](https://github.com/facebook/FBMemoryProfiler)、[DoraemonKit](https://github.com/didi/DoraemonKit)等等，这些都是比较成熟的项目，我们也可以去实现一个。

项目地址[BalaenicepsRex](https://github.com/BiBoyang/BalaenicepsRex)

## 移动的悬浮按钮
首先，我们要创建一个始终待在最上层的view，类似微信中的悬浮球。
这里我们可以直接使用UIWindow的方法。

#### UIWindow简介
UIWindow是一种特殊的UIView，一般的来说，一个App中会自动创建一个，我们看到的页面都在它的上边。但是我们也可以手动创建多个UIWindow，已达到一些特殊的UI效果。
UIWindow在app中主要有以下几种作用：
> 1. 作为视图容器，放置我们使用的视图控件；
> 2. 作为触摸事件传递链的一部分，传递触摸事件和响应事件；
> 3. 参与到设备方向转换。

制作一个UIView添加到UIWindow上有两种方式：
```
[self.rootViewController.view addSubview:self.entryView];
[self addSubview: self.entryView];
```
之前我一直使用的是第二种方式，但是实际上，第二种方式是存在致命的问题的。

当你创建的一个`view`并添加到`UIWindow`上的时候，这个`View`其实是直接添加到`UIWindow`层上的，和当前的`UIViewController`保持相对独立的关系。但是我们如果提前销毁掉`UIViewController`的话，view并不会知道，这也就可能会造成崩溃。

另外还有一种情况，当你旋转当前的视图的时候，是UIApplication先接收到这个消息，然后转发给UIWindow，接着是当前window的rootViewController。但是使用 `addSubview`方法的时候，会让这个添加到UIWindow的视图不跟着旋转。

这么一来我们就通过第一种的方式，创建了一个悬浮在页面上的UIView。

## WindowLevel
什么是 **WindowLevel**？
它代表了UIWindow的层级关系。
```C++
UIKIT_EXTERN const UIWindowLevel UIWindowLevelNormal;
UIKIT_EXTERN const UIWindowLevel UIWindowLevelAlert;
UIKIT_EXTERN const UIWindowLevel UIWindowLevelStatusBar __TVOS_PROHIBITED;
```
这是三种比较普通的WindowLevel，看到名称我们也可以明白他们的含义，普通的Normal代表了当前视图所在的level，Alert代表了系统提示框代表的level，StatusBar代表的是status的level。它们都有一个值。
> * UIWindowLevelNormal - 0
> * UIWindowLevelStatusBar - 1000
> * UIWindowLevelAlert - 2000

这个值我们可以看做是它们的高度值，越高的展示的层级越高，越靠上。

所以我们创建的时候需要这么去创建
```C++
    self.windowLevel = UIWindowLevelAlert + 5;
    if (!self.rootViewController)
    {
        self.rootViewController = [[UIViewController alloc] init];
    }
    
    self.entryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.entryView.backgroundColor = [UIColor blueColor];
    [self.rootViewController.view addSubview:self.entryView];
```
这里设置5是因为后来系统添加了一个 **UITextEffectsWindow**，这是键盘所在的Window，它的Level值是10。

到这里，我们就创建一个悬浮球成功了。

## 滑动

这个其实很简单。

```C++
- (void)panEntryView:(UIPanGestureRecognizer *)pan {

    CGPoint offsetPoint = [pan translationInView:pan.view];
    [pan setTranslation:CGPointZero inView:pan.view];
    UIView *panView = pan.view;
    CGFloat newX = panView.center.x + offsetPoint.x;
    CGFloat newY = panView.center.y + offsetPoint.y;
    
    if (newX < kEntryViewSize / 2) {
        newX = kEntryViewSize / 2;
    }
    if (newX > [UIScreen mainScreen].bounds.size.width + kEntryViewSize / 2) {
        newX = [UIScreen mainScreen].bounds.size.width + kEntryViewSize / 2;
    }

    if (newY < kEntryViewSize / 2) {
        newY = kEntryViewSize / 2;
    }

    if (newY > [UIScreen mainScreen].bounds.size.height + kEntryViewSize / 2) {
        newY = [UIScreen mainScreen].bounds.size.height + kEntryViewSize / 2;
    }

    panView.center = CGPointMake(newX, newY);
}
```

## 模态弹出
因为在我创建的UIWindow中并没有UINavigationView的存在，所以我们需要选用模态的方式去弹出控制中心。
但是 **presentViewController:animated:completion**方法是需要一个当前控制器的。这时候我们需要通过下面的代码获取到当前的控制器。
```C++
UIViewController *vc = [[[UIApplication sharedApplication].delegate window] rootViewController];
BRWindowViewController *controller = [[BRWindowViewController alloc]init];
[vc presentViewController:controller animated:YES completion:nil];

```

## 单例的问题

我在创建这个工具的时候使用了非常多的单例来保证数据统计的持续性。
我们知道过多的单例的弊端，常驻内存，占用CPU等等，实际上这个本身也是会给我们测量带来问题的。但是我们工具的定位本身就是debug阶段使用的开发工具，造成的性能问题是在我们可以忍受的范围之内的。


