//
//  CZLaunchVCDemoVC.m
//  CZKitDemo
//
//  Created by Apple on 2017/3/21.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "CZLaunchVCDemoVC.h"
#import "CZLaunchVC.h"

@interface CZLaunchVCDemoVC () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *cellTitleList;

@end

@implementation CZLaunchVCDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.title = @"多种形式启动画面";
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

- (NSArray *)cellTitleList {
	if (!_cellTitleList) {
		_cellTitleList = @[@"视频播放的启动画面",
						   @"多张图片滑动展示的启动画面",
						   @"单张图片倒计时展示的启动画面",
						   @"GIF 图片动画展示的启动画面"];
	}
	return _cellTitleList;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.cellTitleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *kLaunchCell = @"LaunchCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLaunchCell];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kLaunchCell];
	}
	cell.textLabel.text = self.cellTitleList[indexPath.row];
	return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	switch (indexPath.row) {
		case 0:
			[self launchMovieAction];
			break;
		case 1:
			[self launchMultiImagesAction];
			break;
		case 2:
			[self launchSingleImageAction];
			break;
		case 3:
			[self launchGIFAction];
			break;
		default:
			break;
	}
}

#pragma mark - Action
/** 使用视频播放的启动画面 */
- (void)launchMovieAction {
	CZLaunchVC *vc = [[CZLaunchVC alloc] init];
	// 视频 URL
	NSURL *url = [[NSBundle mainBundle] URLForResource:@"Hotel California_ Short - The Eagles" withExtension:@"mp4"];	// 本地视频 URL
//	NSURL *url = [NSURL URLWithString:@"http://om4ic0f3x.bkt.clouddn.com/Hotel%20California_%20Short%20-%20The%20Eagles.mp4"];	// 远程视频 URL
	[vc launchWithMovieURL:url
					config:^(UIButton *enterButton) {
						enterButton.frame = CGRectMake(0.0, 0.0, 100.0, 30.0);
						enterButton.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 100.0);
						[enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
						[enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
					}
					 enter:^{
//						 // 应用首页
//						 ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
//						 self.window.rootViewController = vc;
//						 // 显示新的 rootViewController 时的过渡动画
//						 [self.window.layer transitionWithType:kCATransitionFade subtype:kCATransitionFromTop timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut duration:2.0];
						 
						 [vc dismissViewControllerAnimated:YES completion:nil];
					 }];
//	self.window.rootViewController = vc;
	
	[self presentViewController:vc animated:YES completion:nil];
}

/** 使用多张图片滑动展示的启动画面 */
- (void)launchMultiImagesAction {
	CZLaunchVC *vc = [[CZLaunchVC alloc] init];
	[vc launchWithImages:@[[UIImage imageNamed:@"launch0"],
						   [UIImage imageNamed:@"launch1"],
						   [UIImage imageNamed:@"launch2"]]
	   configEnterButton:^(UIButton *enterButton) {
		   enterButton.frame = CGRectMake(0.0, 0.0, 100.0, 30.0);
		   enterButton.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 100.0);
		   [enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
		   [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	   }
	   configPageControl:^(UIPageControl *pageControl) {
		   pageControl.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 15.0 - 37.0 / 2.0);
		   pageControl.hidesForSinglePage = YES;
	   }
				   enter:^{
//					   // 应用首页
//					   ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
//					   self.window.rootViewController = vc;
//					   // 显示新的 rootViewController 时的过渡动画
//					   [self.window.layer transitionWithType:kCATransitionFade subtype:kCATransitionFromTop timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut duration:2.0];
					   
					   [vc dismissViewControllerAnimated:YES completion:nil];
				   }];
//	self.window.rootViewController = vc;
	
	[self presentViewController:vc animated:YES completion:nil];
}

/** 使用单张图片倒计时展示的启动画面 */
- (void)launchSingleImageAction {
	CZLaunchVC *vc = [[CZLaunchVC alloc] init];
	[vc launchWithImage:[UIImage imageNamed:@"launch0"] duration:3
				 config:^(UIButton *enterButton) {
					 enterButton.frame = CGRectMake(0.0, 0.0, 100.0, 30.0);
					 enterButton.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 100.0);
					 [enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
					 [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
				 }
				  enter:^{
//					  // 应用首页
//					  ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
//					  self.window.rootViewController = vc;
//					  // 显示新的 rootViewController 时的过渡动画
//					  [self.window.layer transitionWithType:kCATransitionFade subtype:kCATransitionFromTop timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut duration:2.0];
					  
					  [vc dismissViewControllerAnimated:YES completion:nil];
				  }];
//	self.window.rootViewController = vc;
	
	[self presentViewController:vc animated:YES completion:nil];
}

/** GIF 图片动画展示的启动画面 */
- (void)launchGIFAction {
	CZLaunchVC *vc = [[CZLaunchVC alloc] init];
	[vc launchWithGIFNamed:@"Hotel-California_-Short-The-Eagles"
			   repeatCount:2
					config:^(UIButton *enterButton) {
						enterButton.frame = CGRectMake(0.0, 0.0, 100.0, 30.0);
						enterButton.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 100.0);
						[enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
						[enterButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
					}
					 enter:^{
//						 // 应用首页
//						 ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
//						 self.window.rootViewController = vc;
//						 // 显示新的 rootViewController 时的过渡动画
//						 [self.window.layer transitionWithType:kCATransitionFade subtype:kCATransitionFromTop timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut duration:2.0];
					  
					  [vc dismissViewControllerAnimated:YES completion:nil];
					 }];
//	self.window.rootViewController = vc;
	
	[self presentViewController:vc animated:YES completion:nil];
}

@end
