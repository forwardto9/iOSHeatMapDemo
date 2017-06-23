//
//  NSObject+Swizzling.m
//  HeatMapDemo
//
//  Created by uwei on 23/06/2017.
//  Copyright © 2017 Tencent. All rights reserved.
//

#import "NSObject+Swizzling.h"
@implementation NSObject (Swizzling)

+ (void)swizzleMethods:(Class) class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel {
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
    
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, swizMethod);
    }
}

@end
