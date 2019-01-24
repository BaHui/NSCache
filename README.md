# iOS之NSCache

## 简述
1. 官方提供的缓存类，用法与NSMutableDictionary的用法很相似，使用它来管理缓存。
2. 在系统内存很低时，会自动释放一些对象;
3. NSCache是线程安全的。
4. NSCache的key只是做强引用，不需要实现NSCopying协议。

## 官方接口
```
// 属性
@property NSUInteger totalCostLimit;   // 设置缓存数量
@property NSUInteger countLimit;     // 设置最大花费量
@property BOOL evictsObjectsWithDiscardedContent;` // 是否移除不再被使用的对象

// 方法
- (nullable ObjectType)objectForKey:(KeyType)key;
- (void)setObject:(ObjectType)obj forKey:(KeyType)key; // 0 cost
- (void)setObject:(ObjectType)obj forKey:(KeyType)key cost:(NSUInteger)g;
- (void)removeObjectForKey:(KeyType)key;
- (void)removeAllObjects;

// 协议
@protocol NSCacheDelegate <NSObject>
@optional
- (void)cache:(NSCache *)cache willEvictObject:(id)obj;

@end
```

## 属性设置

##### 情景一: 仅设置缓存数量: `countLimit`, 可用`setObject: forKey:`加入对象
```
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

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
NSLog(@"willEvictObject: %@", obj); //   输出: 1 2 3
}
```

##### 情景二: 仅设置最大花费量 `totalCostLimit` , 可以`setObject: forKey: cost:`加入对象
```
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

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
NSLog(@"willEvictObject: %@", obj); // 1 2 3 4 5 6
}
```
##### 情景三: 设置 缓存数量&最大花费量 `countLimit & totalCostLimit` , 可用`setObject: forKey:` &  `setObject: forKey: cost:`加入对象
```
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

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
NSLog(@"willEvictObject: %@", obj);
// 101 1 102 2 103 3 104 4 105 5 106
}
```

### 交流与建议
*   GitHub：[https://github.com/BaHui](https://github.com/BaHui)
*   邮    箱：[qiaobahuiyouxiang@163.com](mailto:qiaobahuiyouxiang@163.com)
