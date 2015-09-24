//
//  HorizontalCollectionViewInit.m
//  UICollectionView
//
//  Created by 李佳 on 15/9/24.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "HorizontalCollectionViewInit.h"
#import "LJCollectionViewCell.h"


@implementation HorizontalCollectionViewInit

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 18;
}

//@optional

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage* image = [UIImage imageNamed:@"doge_1.png"];
    return CGSizeMake(image.size.width, image.size.height);
}


@end
