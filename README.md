# DouYuDemo
模仿斗鱼TV IOSAPP

### 一些知识点：
1.修改Tabbar的tintColor（[appearance方法详解]）
[appearance方法详解]:(http://www.jianshu.com/p/90d826315474)
`UITabBar.appearance().tintColor = UIColor.orange`<br>

2.ios9后的新特性，storyboard可以分割管理，选中要分离出来的storyBoard中的某个控制器：**Editor -> Refactor to storyBoard** ,生成新的包含该控制器的storyBoard；<br>

如果要适配ios8，为每个storyBoard生成一个控制器文件并绑定，并在TabbarController中addChildrenViewController。<br>

3.swif中weak只能修饰可选类型。

4.`extern double floor(double);`系统函数，表示取该数的整数部分

5.`UICollectionViewDelegateFlowLayout`继承自`UICollectionViewDelegate`

6.OC中使用**AFNetworking**，作者针对OC开发了**Alamofire**用来进行网络请求。一般对使用的第三方库需要进行自己的封装，避免过于依赖框架。

7.**Kingfisher**,Swift用于加载网络图片的框架，类似OC中的SDWebImage。

8.使用XIB布局时，在`awakeFromNib()`方法得到的控件尺寸是不准确的，是XIB中的大小；这时可以重写`layoutSubviews()`,从该方法可以获得


### 一些实现思路 
1.首页导航栏的UIBarButtonItem，扩展extension。<br>

2.首页顶部滑动切换（也可用于其他页面，一同封装）
>(1).封装PageTitleView<br>
>>* 自定义View，并且自定义构造函数
>>* 添加子控件：1.UIScrollView；2.设置TitleLabel;3.设置底部line

>(2).封装PageContentView<br>
>>* 自定义View，并且自定义构造函数
>>* 添加子控件：1.UICollectionView；2.设置UICollectionView的内容

>(3).处理PageTitleView & PageContentView的逻辑
>>* pagetitleView中发生点击:1. PageTitleView逻辑处理；2. PageContentView滚动到相应位置。
>>* pageContentView的滚动

3.无限轮播
>(1).可以使用第三方框架。<br>
>(2).自定义UIScrollView。需要考虑循环利用的问题。<br>
>(3)UICollectionView(推荐)


### MVVM设计模式

#### MVVM介绍
* 前面环境配置完成后，我们要请求首页数据
* 数据请求在哪里发送了<br>

#### MVC模式
* Model-View-Controller,苹果官方推荐的权威范式。
* 那么把网络代码放在哪里<br>

        1.我们知道，因为控制器是一个大管家，那么不知道如何安放
        的代码就放在控制器中。
        2.是的，传统的MVC方式我们经常这么做。
        
* 该做法的弊端在哪里<br>

        1.由于大量的代码被放进view controller,导致控制器变    
        得相当臃肿。
        2.在ios开发中有的view controller里延绵成千上万的代
        码并不是前所未见的。
        3.厚重的view controller很难维护；包含几十个属性，使
        他们的状态难以管理；遵循许多协议。导致协议的响应代码和
        controller的逻辑代码混淆在一起。
        
* 那么究竟应该放在哪里<br>

        显然MVC的三大组件没有适合放这些代码的地方。
        
![Alt text](http://ow7i1tw26.bkt.clouddn.com/MVC.png)

#### MVVM模式
* MVVM来自微软，并引入新的组件ViewModel<br>
           
        1.view model是一个放置用户输入验证逻辑，视图显示逻 
        辑，发起网络请求和其他各式各样的代码的极好的地方。
        2.由于展示逻辑放在了view model中（比如网络请求、请求
        后的数据解析等等），视图控制器本身就不会再臃肿。

* 因此，该项目中的请求数据，统一交给viewModel管理，每一个控制器对应        
        
![Alt text](http://ow7i1tw26.bkt.clouddn.com/MVVM.png)