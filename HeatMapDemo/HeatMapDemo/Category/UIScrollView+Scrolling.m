//
//  UIScrollView+Scrolling.m
//  HeatMapDemo
//
//  Created by uwei on 23/06/2017.
//  Copyright © 2017 Tencent. All rights reserved.
//

#import "UIScrollView+Scrolling.h"
#import "NSObject+Swizzling.h"
@implementation UIScrollView (Scrolling)

+ (void)load {
    [UIScrollView hook];
}


+ (void)hook {
    SEL originalM1 = @selector(setContentOffset:);
    SEL replaceM1 = @selector(hookSetContentOffset:);
    [UIScrollView swizzleMethods:[self class] originalSelector:originalM1 swizzledSelector:replaceM1];
}

- (void)hookSetContentOffset:(CGPoint)contentOffset {
    NSLog(@"content offset");
    [self hookSetContentOffset:contentOffset];
}



@end
