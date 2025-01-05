The solution involves explicitly removing the observer before the observed object is deallocated.  Here's the corrected code:

```objectivec
@interface MyObservedObject : NSObject
@property (nonatomic, strong) NSString *observedProperty;
@end

@implementation MyObservedObject
// ...
@end

@interface MyObserver : NSObject
@end

@implementation MyObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // ... access observedProperty ...
}
@end

//In some other class
MyObservedObject *obj = [[MyObservedObject alloc] init];
MyObserver *observer = [[MyObserver alloc] init];
[obj addObserver:observer forKeyPath:@"observedProperty" options:NSKeyValueObservingOptionNew context:NULL];

// ... some code ...
[obj removeObserver:observer forKeyPath:@"observedProperty"];
[obj release];
[observer release]; //Important for old versions. If you are using ARC, you don't need this line.

```

By calling `removeObserver:forKeyPath:` before releasing `obj`, we prevent the crash.  In modern Objective-C with ARC, the `release` calls are not needed, but the `removeObserver` call remains crucial.