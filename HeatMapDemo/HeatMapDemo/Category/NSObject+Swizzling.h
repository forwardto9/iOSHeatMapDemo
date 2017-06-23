//
//  NSObject+Swizzling.h
//  HeatMapDemo
//
//  Created by uwei on 23/06/2017.
//  Copyright © 2017 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSObject (Swizzling)
+ (void)swizzleMethods:(Class) class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel;
@end
