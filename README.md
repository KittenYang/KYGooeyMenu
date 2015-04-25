# KYGooeyMenu
带粘性的扇形菜单

灵感来自[这个Dribbble设计](https://dribbble.com/shots/1936758-GIF-of-the-Tap-Bar-Concept)

![](dribble_demo_gif)

下面是实现的效果：
###1、点击每个具体的菜单可以获得相信的编号，使用时，可以switch这个序号进行想要的后续操作。
###2、可自定义菜单个数。
###3、可自定义父菜单和子菜单间距。
###4、自定义颜色

![](gooey.gif)

##Usage
###Initialize
```
    gooeyMenu = [[KYGooeyMenu alloc]initWithOrigin:CGPointMake(CGRectGetMidX(self.view.frame)-50, 500) andDiameter:100.0f andDelegate:self themeColor:[UIColor redColor]];
    gooeyMenu.menuDelegate = self;
    gooeyMenu.radius = 100/4;     //这里把小圆半径设为大圆的1/4
    gooeyMenu.extraDistance = 20; //间距设为R+r+20。注：R+r是默认存在的。
    gooeyMenu.MenuCount = 4;      //4个子菜单

```

###implement protocol method
```
-(void)menuDidSelected:(NSInteger)index{
    NSLog(@"选中第%ld",(long)index);
}


```


##*That's it!*    *Enjoy!*
