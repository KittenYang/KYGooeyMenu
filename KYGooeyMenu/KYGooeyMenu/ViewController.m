//
//  ViewController.m
//  KYGooeyMenu
//
//  Created by Kitten Yang on 4/23/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "ViewController.h"
#import "KYGooeyMenu.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *min;
@property (strong, nonatomic) IBOutlet UILabel *current;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@end

@implementation ViewController{
    KYGooeyMenu *gooeyMenu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.min.text = [NSString stringWithFormat:@"%d",(int)self.slider.minimumValue] ;
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

    gooeyMenu = [[KYGooeyMenu alloc]initWithOrigin:CGPointMake(CGRectGetMidX(self.view.frame)-50, 500) andDiameter:100.0f andDelegate:self themeColor:[UIColor redColor]];
    gooeyMenu.MenuCount = 4;
    
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
