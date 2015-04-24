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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KYGooeyMenu *gooeyMenu = [[KYGooeyMenu alloc]initWithOrigin:self.view.center andRadius:100.0f andMenuCount:3 andDelegate:self themeColor:[UIColor redColor]];
    [gooeyMenu setUp];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
