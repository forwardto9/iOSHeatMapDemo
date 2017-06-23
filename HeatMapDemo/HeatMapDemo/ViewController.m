//
//  ViewController.m
//  HeatMapDemo
//
//  Created by uwei on 16/06/2017.
//  Copyright © 2017 Tencent. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [(UIScrollView *)self.view setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 1000)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
