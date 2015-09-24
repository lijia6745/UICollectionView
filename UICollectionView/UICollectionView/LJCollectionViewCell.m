//
//  LJCollectionViewCell.m
//  UICollectionView
//
//  Created by 李佳 on 15/9/23.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "LJCollectionViewCell.h"

@interface LJCollectionViewCell()

@property(nonatomic, strong)UIImageView* showImageView;
@property(nonatomic, strong)UILabel* imageInfo;

@end

@implementation LJCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.showImageView = [[UIImageView alloc] init];
        self.backgroundColor = [UIColor grayColor];
    }
    
    return self;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.showImageView.image = [UIImage imageNamed:_imageName];
    self.showImageView.frame = self.bounds;
    [self addSubview:self.showImageView];
}

- (NSString*)getImageInfo: (UIImage*) image
{
    return [NSString stringWithFormat:@"image:%@", image.description];
}


@end
