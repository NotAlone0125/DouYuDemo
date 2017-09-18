# DouYuDemo
模仿斗鱼TV IOSAPP

###一些知识点：<br>
1.修改Tabbar的tintColor（[appearance方法详解]）
[appearance方法详解]:(http://www.jianshu.com/p/90d826315474)
`UITabBar.appearance().tintColor = UIColor.orange`<br>

2.ios9后的新特性，storyboard可以分割管理，选中要分离出来的storyBoard中的某个控制器：**Editor -> Refactor to storyBoard** ,生成新的包含该控制器的storyBoard；<br>

如果要适配ios8，为每个storyBoard生成一个控制器文件并绑定，并在TabbarController中addChildrenViewController。


###一些实现思路
1.首页导航栏的UIBarButtonItem，扩展extension。<br>

2.首页顶部滑动切换（也可用于其他页面，一同封装）
>(1).封装PageTitleView<br>
>>* 自定义View，并且自定义构造函数
>>* 添加子控件：1.UIScrollView；2.设置TitleLabel;3.设置底部line

>(2).封装PageContentView<br>
>>* 
>(3).处理PageTitleView & PageContentView的逻辑