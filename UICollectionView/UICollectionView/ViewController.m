//
//  ViewController.m
//  UICollectionView
//
//  Created by 李佳 on 15/9/22.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "ViewController.h"
#import "LJCollectionViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [self pushLJCollectionView:nil];
    UIButton* btn = [[UIButton alloc] init];
    [btn addTarget:self action:@selector(pushLJCollectionView:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 80, 20);
    [btn setTitle:@"瀑布流" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
}

- (void)pushLJCollectionView: (id)sender
{
    UICollectionViewLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    LJCollectionViewController* collectionCrl = [[LJCollectionViewController alloc] initWithCollectionViewLayout:layout];
    [self.navigationController pushViewController:collectionCrl animated:NO];
}

@end
