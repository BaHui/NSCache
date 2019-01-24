//
//  BHExampleViewController.h
//  BHDemo
//
//  Created by QiaoBaHui on 2019/1/24.
//  Copyright © 2019年 QiaoBaHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHExampleViewController : UIViewController <NSCacheDelegate>

@property (nonatomic, strong) NSCache *cache;

+ (instancetype)create;

@end
