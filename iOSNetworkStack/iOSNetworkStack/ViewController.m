//
//  ViewController.m
//  iOSNetworkStack
//
//  Created by Zach McArtor on 4/27/15.
//  Copyright (c) 2015 HackaZach. All rights reserved.
//

#import "ViewController.h"
#import "TheNetwork.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    TheNetwork *thenetwork = [[TheNetwork alloc] init];
    [thenetwork whatsMyIP:^(NSString *ip) {
        NSLog(@"THE IP IS : %@", ip);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
