//
//  ViewController.m
//  ImitateTmallSearchPage
//
//  Created by carrot__lsp on 2018/11/15.
//  Copyright © 2018年 carrot.dbd. All rights reserved.
//

#import "ViewController.h"
#import "DDFeedSearchViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)searchAction {
    DDFeedSearchViewController *vc = [DDFeedSearchViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav
                       animated:YES completion:nil];
}


@end
