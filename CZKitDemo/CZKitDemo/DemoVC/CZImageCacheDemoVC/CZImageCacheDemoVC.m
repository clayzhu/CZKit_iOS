//
//  CZImageCacheDemoVC.m
//  CZKitDemo
//
//  Created by Apple on 2017/3/21.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "CZImageCacheDemoVC.h"
#import "CZImageCache.h"

@interface CZImageCacheDemoVC ()
@property (weak, nonatomic) IBOutlet UILabel *allCacheSizeLbl;
@property (weak, nonatomic) IBOutlet UILabel *imageCacheSizeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CZImageCacheDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.title = @"图片缓存";
	[self setupCacheLabel];
	// 从网络 URL 请求图片，若缓存中存在，则从缓存取
	[[CZImageCache sharedInstance] imageForImageView:self.imageView
											imageURL:@"http://ompmj0bxx.bkt.clouddn.com/IMG_1382.JPG"
									placeholderImage:nil
											 success:^(UIImage *image) {
												 // 请求到图片后，会缓存到沙盒中，刷新沙盒中缓存的大小
												 [self setupCacheLabel];
											 }];
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

/** 读取缓存大小，设置 UI */
- (void)setupCacheLabel {
	self.allCacheSizeLbl.text = [NSString stringWithFormat:@"全部缓存大小：%.2fM", [[CZImageCache sharedInstance] cacheSize]];
	self.imageCacheSizeLbl.text = [NSString stringWithFormat:@"图片缓存大小：%.2fM", [[CZImageCache sharedInstance] imageCacheSize]];
}

/** 清理所有缓存，路径为 /Library/Caches */
- (IBAction)clearAllCacheAction:(UIButton *)sender {
	[[CZImageCache sharedInstance] clearCacheWithCompletion:^{
		[self setupCacheLabel];
	}];
}

/** 清理图片缓存，路径为 /Library/Caches/ImageCache */
- (IBAction)clearImageCacheAction:(UIButton *)sender {
	[[CZImageCache sharedInstance] clearImageCacheWithCompletion:^{
		[self setupCacheLabel];
	}];
}

@end
