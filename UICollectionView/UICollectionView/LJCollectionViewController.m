//
//  LJCollectionViewController.m
//  UICollectionView
//
//  Created by 李佳 on 15/9/23.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "LJCollectionReusableView.h"
#import "LJCollectionViewController.h"
#import "LJCollectionViewCell.h"
#import "LJCollectionView.h"
#import "UIDefines.h"
#import "HorizontalCollectionViewInit.h"

@interface LJCollectionViewController ()
@property(nonatomic, strong)LJCollectionView* horizontalCollectionView;
@end


@implementation LJCollectionViewController

static NSString* const reuseIdentifier = @"Cell";
static NSString* const kfooterIdentifier = @"kfooterIdentifier";
static NSString* const kheaderIdentifier = @"kheaderIdentifier";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithCollectionViewLayout:layout])
    {
        self.view.backgroundColor = [UIColor whiteColor];
        [self initWithVerticalCollectionView];
        [self initWithHorizontalColltionView];
    }
    return self;
}

- (void)initWithHorizontalColltionView
{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [layout setMinimumInteritemSpacing:0];
    
    self.horizontalCollectionView = [[LJCollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.horizontalCollectionView registerClass:[LJCollectionViewCell class] forCellWithReuseIdentifier:@"HorizontalCell" ];
    
    self.horizontalCollectionView.delegate = self;
    self.horizontalCollectionView.dataSource  = self;
    
    self.horizontalCollectionView.frame = CGRectMake(0, 64, self.view.frame.size.width, 66);
    self.horizontalCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.horizontalCollectionView];
}

- (void)initWithVerticalCollectionView
{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    layout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 30.f);
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 20.f);
//    layout.sectionHeadersPinToVisibleBounds = YES;
//    layout.sectionFootersPinToVisibleBounds = YES;
    
    //layout.sectionInset = UIEdgeInsetsMake(4 * margins, margins, 4 * margins , margins);
    
    self.collectionView = [[LJCollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[LJCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[LJCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    [self.collectionView registerClass:[LJCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.frame = CGRectMake(0, 66, self.view.frame.size.width, self.view.frame.size.height);;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSArray*)getShowImageArr
{
    NSMutableArray* imageNames = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 18; ++i)
    {
        NSString* imageName = [NSString stringWithFormat:@"doge_%d", i + 1];
        [imageNames addObject:imageName];
    }
    return imageNames;
}


#pragma mark <UICollectionViewDataSource>
//@required

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout* layout = (UICollectionViewFlowLayout*)collectionView.collectionViewLayout;
    if (layout.scrollDirection == UICollectionViewScrollDirectionHorizontal)
    {
        LJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HorizontalCell" forIndexPath:indexPath];
        cell.imageName = [NSString stringWithFormat:@"doge_%ld", (indexPath.row + 1)];
        return cell;
    }
    else
    {
        LJCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        
        NSArray* images = [self getShowImageArr];
        NSLog(@"%ld, %ld", (long)indexPath.section, (long)indexPath.row);
        NSUInteger position = (indexPath.section * 3 + indexPath.row) % 18;
        position = MIN(position, images.count - 1);
        cell.imageName = images[position];
        
        return cell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    UICollectionViewFlowLayout* layout = (UICollectionViewFlowLayout*)collectionView.collectionViewLayout;
    if (layout.scrollDirection == UICollectionViewScrollDirectionHorizontal)
        return 18;
    else
        return 3;
}

//@optional

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    UICollectionViewFlowLayout* layout = (UICollectionViewFlowLayout*)collectionView.collectionViewLayout;
    if (layout.scrollDirection == UICollectionViewScrollDirectionHorizontal)
        return 1;
    else
        return 10;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout* layout = (UICollectionViewFlowLayout*)collectionView.collectionViewLayout;
    if (layout.scrollDirection == UICollectionViewScrollDirectionHorizontal)
    {
        UIImage* image = [UIImage imageNamed:@"doge_1.png"];
        return CGSizeMake(image.size.width, image.size.height);
    }
    else
    {
        CGFloat width = (self.view.frame.size.width - 4 * margins - 20) / 3;
        CGFloat height = (arc4random() % 2 + 1) * width;
        return CGSizeMake(width, height);
    }
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ])
    {
        reuseIdentifier = kfooterIdentifier;
    }
    else
    {
        reuseIdentifier = kheaderIdentifier;
    }
    
    LJCollectionReusableView *view =  (LJCollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        view.backgroundColor = [UIColor yellowColor];
        view.label.text = [NSString stringWithFormat:@"这是header:%ld",(long)indexPath.section];
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        view.backgroundColor = [UIColor lightGrayColor];
        view.label.text = [NSString stringWithFormat:@"这是footer:%ld",(long)indexPath.section];
    }
    return view;
}

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UICollectionViewFlowLayout* layout = (UICollectionViewFlowLayout*)collectionView.collectionViewLayout;
    if (layout.scrollDirection == UICollectionViewScrollDirectionVertical)
        return UIEdgeInsetsMake(margins, margins, margins, margins);//分别为上、左、下、右
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark <UICollectionViewDelegate>

/*高亮相关 控制*/
/*
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    LJCollectionViewCell* cell = (LJCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    cell.backgroundColor = [UIColor greenColor];
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    LJCollectionViewCell* cell = (LJCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
}
 */

/*选中相关控制*/
/*
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LJCollectionViewCell* cell = (LJCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSLog(@"%ld, %ld", (long)indexPath.section, (long)indexPath.row);
    cell.selected = YES;
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LJCollectionViewCell* cell = (LJCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
}
*/

/*cell和header元素的显示*/
/*
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 1)
        cell.hidden = YES;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.hidden = NO;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    
}
*/

/*菜单管理*/
// These methods provide support for copy/paste actions on cells.
// All three should be implemented if any are.
/*
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    
}
*/

@end
