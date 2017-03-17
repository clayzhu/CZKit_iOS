//
//  ViewController.m
//  CZKitDemo
//
//  Created by Apple on 2017/3/16.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 从 DemoVCList.plist 中读取，向后跳转到某个特定 library 的 DemoViewController 的名字的数组 */
@property (strong, nonatomic) NSArray *demoVCList;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.title = @"CZKit Demo";
	self.demoVCList = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DemoVCList" ofType:@"plist"]];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.demoVCList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"LibraryNameCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (! cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
	cell.textLabel.text = [NSString stringWithFormat:@"%@、%@", @(indexPath.row + 1), self.demoVCList[indexPath.row]];
	return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	UIViewController *vc = [[NSClassFromString(self.demoVCList[indexPath.row]) alloc] init];	// 通过类名加载 vc
	[self.navigationController pushViewController:vc animated:YES];
}

@end
