//
//  ViewController.m
//  KYGooeyMenu
//
//  Created by Kitten Yang on 4/23/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "ViewController.h"
#import "KYGooeyMenu.h"
#import "Menu.h"

@interface ViewController ()<menuDidSelectedDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *showDedugPoints;

@property (strong, nonatomic) IBOutlet UILabel *min;
@property (strong, nonatomic) IBOutlet UILabel *current;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong,nonatomic)  Menu *menu;

@end

@implementation ViewController{
    KYGooeyMenu *gooeyMenu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.min.text = [NSString stringWithFormat:@"%d",(int)self.slider.minimumValue] ;
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.slider.hidden = YES;
    self.min.hidden = YES;
    self.current.hidden = YES;
    
//    gooeyMenu = [[KYGooeyMenu alloc]initWithOrigin:CGPointMake(CGRectGetMidX(self.view.frame)-50, 500) andDiameter:100.0f andSuperView:self.view themeColor:[UIColor redColor]];
    gooeyMenu.menuDelegate = self;
    gooeyMenu.radius = 100/4;//大圆的1/4
    gooeyMenu.extraDistance = 20;
    gooeyMenu.MenuCount = 5;
    gooeyMenu.menuImagesArray = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"tabbarItem_discover highlighted"],[UIImage imageNamed:@"tabbarItem_group highlighted"],[UIImage imageNamed:@"tabbarItem_home highlighted"],[UIImage imageNamed:@"tabbarItem_message highlighted"],[UIImage imageNamed:@"tabbarItem_user_man_highlighted"], nil];

    
    
    
    //*******test version*******
    _menu = [[Menu alloc]initWithFrame:CGRectMake(self.view.center.x-50, self.view.frame.size.height - 200, 100, 100)];
    [self.view addSubview:_menu];
    [self.showDedugPoints addTarget:self action:@selector(showDedug:) forControlEvents:UIControlEventValueChanged];
    
    
}

-(void)showDedug:(UISwitch *)sender{

    if (sender.on) {
        _menu.menuLayer.showDebug = YES;
    }else{
        _menu.menuLayer.showDebug = NO;
    }
    
    [_menu.menuLayer setNeedsDisplay];
    
}


#pragma mark -- 彩单选中的代理方法
-(void)menuDidSelected:(int)index{
    NSLog(@"选中第%d",index);
}


- (void)sliderValueChanged:(UISlider *)sender {
    self.current.text = [NSString stringWithFormat:@"%d",(int)sender.value];

    gooeyMenu.MenuCount = (int)sender.value;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
