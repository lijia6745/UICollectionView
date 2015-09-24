//
//  LJCollectionReusableView.m
//  UICollectionView
//
//  Created by 李佳 on 15/9/23.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "LJCollectionReusableView.h"

@interface LJCollectionReusableView()
@end

@implementation LJCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.label = [[UILabel alloc] init];
        self.label.frame = self.bounds;
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
    }
    return self;
}
@end
