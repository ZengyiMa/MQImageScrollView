//
//  ViewController.m
//  MQImageScrollView
//
//  Created by WsdlDev on 15/10/10.
//  Copyright © 2015年 mazengyi. All rights reserved.
//

#import "ViewController.h"
#import "MQImageScrollView.h"


@interface ViewController ()

@property (nonatomic, strong) MQImageScrollView *mqisv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _mqisv = [[MQImageScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    [self.view addSubview:_mqisv];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:[UIImage imageNamed:@"1"]];
    [arr addObject:[UIImage imageNamed:@"2"]];
     [arr addObject:[UIImage imageNamed:@"3"]];
     [arr addObject:[UIImage imageNamed:@"4"]];
    [arr addObject:[UIImage imageNamed:@"5"]];
    [arr addObject:[UIImage imageNamed:@"6"]];
    [arr addObject:[UIImage imageNamed:@"7"]];
    [_mqisv showImages:arr ChangePageInterval:2];
    [_mqisv setSelectedBlock:^(NSUInteger index) {
        NSLog(@"%lu", (unsigned long)index);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
