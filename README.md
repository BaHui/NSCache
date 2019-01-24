# NSCache

NSCache是苹果官方提供的缓存类，用法与NSMutableDictionary的用法很相似，在AFNetworking和SDWebImage中，使用它来管理缓存。     
NSCache在系统内存很低时，会自动释放一些对象;  
NScache是线程安全的，在多线程操作中，不需要对Cache加锁。   
NScache的key只是做强引用，不需要实现NScopying协议。   
