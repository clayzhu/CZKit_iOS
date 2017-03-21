//
//  CZColorDemoVC.m
//  CZKitDemo
//
//  Created by Apple on 2017/3/21.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "CZColorDemoVC.h"
#import "CZKit.h"

static NSString *kColorCell = @"ColorCell";

@interface CZColorDemoVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray<UIColor *> *cellColorList;

@end

@implementation CZColorDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.title = @"扩展生成颜色的方法";
	[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kColorCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSArray<UIColor *> *)cellColorList {
	if (!_cellColorList) {
		_cellColorList = @[[UIColor colorWithRed:246.0 / 255 green:80.0 / 255 blue:70.0 / 255 alpha:0.9],
						   [UIColor colorWithHexString:@"#E5F65046"],
						   [UIColor colorWithHexString:@"#F65046" alpha:0.9],
						   [UIColor colorWithR:246.0 g:80.0 b:70.0],
						   [UIColor colorWithR:246.0 g:80.0 b:70.0 alpha:0.9],
						   [UIColor randomColor]];
	}
	return _cellColorList;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kColorCell forIndexPath:indexPath];
	cell.backgroundColor = self.cellColorList[indexPath.section * 2 + indexPath.item];
	return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
	return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 1.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
	return UIEdgeInsetsMake(0.5, 0.5, 0.5, 0.5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0 - 1.0, CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0 - 1.0);
}

@end
