//
//  BHExampleViewController.m
//  BHDemo
//
//  Created by QiaoBaHui on 2019/1/24.
//  Copyright © 2019年 QiaoBaHui. All rights reserved.
//

#import "BHExampleViewController.h"

@interface BHExampleViewController ()

@end

static NSString *const DEMO_VIEWS_STORYBOARD_NAME = @"DemoViews";


@implementation BHExampleViewController

+ (instancetype)create {
	UIStoryboard *demoViewsStoryboard = [UIStoryboard storyboardWithName:DEMO_VIEWS_STORYBOARD_NAME bundle:nil];
	return [demoViewsStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([BHExampleViewController class])];
}

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self useCacheForOnlyCountLimit];
	[self useCacheForOnlyTotalCostLimit];
	[self useCacheForCountAndTotalCostLimit];
}

/** `countLimit` 设置缓存数量
 *  `setObject: forKey:`
 * 当数量超出时, 默认会先移除最先添加的对象
 */
- (void)useCacheForOnlyCountLimit {
	self.cache = [[NSCache alloc] init];
	self.cache.countLimit = 5; // 设置缓存数量 <<
	self.cache.delegate = self; // 设置代理对象
	
	// 模拟存储数据
	for (NSInteger i = 1; i <= 8; i++) {
		[self.cache setObject:@(i) forKey:@(i)];
	}
}

/** `totalCostLimit` 设置最大花费量
 *  `setObject: forKey: cost:`
 * 当总花费量超出最大花费量, 默认会先移除最先添加的对象
 */
- (void)useCacheForOnlyTotalCostLimit {
	self.cache = [[NSCache alloc] init];
	self.cache.totalCostLimit = 10; // 设置缓存容量 <<
	self.cache.delegate = self; // 设置代理对象
	
	// 模拟存储数据
	for (NSInteger i = 1; i <= 8; i++) {
		[self.cache setObject:@(i) forKey:@(i) cost:5];
	}
}

/** `countLimit & totalCostLimit` 设置 缓存数量&最大花费量
 *  `setObject: forKey:` & `setObject: forKey: cost:`
 * 当缓存数量大于最大缓存数量 或者 总花费量超出最大花费量, 默认会先移除最先添加的对象
 */
- (void)useCacheForCountAndTotalCostLimit {
	self.cache = [[NSCache alloc] init];
	self.cache.countLimit = 5; // 设置缓存数量 <<
	self.cache.totalCostLimit = 20; // 设置缓存容量 <<
	self.cache.delegate = self; // 设置代理对象
	
	// 模拟存储数据
	for (NSInteger i = 1; i <= 8; i++) {
		[self.cache setObject:@(i+100) forKey:@(i+100)];
		[self.cache setObject:@(i) forKey:@(i) cost:1];
	}
}

#pragma mark - NSCacheDelegate

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
	NSLog(@"willEvictObject: %@", obj);
	/*
	 useCacheForOnlyCountLimit Log: 1 2 3
	 useCacheForOnlyTotalCostLimit Log: 1 2 3 4 5 6
	 useCacheForCountAndTotalCostLimit Log: 101 1 102 2 103 3 104 4 105 5 106
	 */
}

@end
