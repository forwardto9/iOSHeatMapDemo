//
//  UIWindow+HitTest.m
//  HeatMapDemo
//
//  Created by uwei on 16/06/2017.
//  Copyright © 2017 Tencent. All rights reserved.
//

#import "UIWindow+HitTest.h"
#import "UIViewController+TopObject.h"
#import "IBHeatMap.h"
#import <objc/runtime.h>

@implementation UIWindow (HitTest)

+ (void)load {
    [UIWindow hook];
}

+ (void)hook {
    SEL hitTest = @selector(hitTest:withEvent:);
    SEL customTitTest = @selector(custom_hook_HitTest:withEvent:);
    [UIWindow swizzleMethods:[self class] originalSelector:hitTest swizzledSelector:customTitTest];
    
    SEL pointInside = @selector(pointInside:withEvent:);
    SEL customPointIndside = @selector(custom_hook_PointInside:withEvent:);
    
    [UIWindow swizzleMethods:[self class] originalSelector:pointInside swizzledSelector:customPointIndside];
}

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

- (UIView *)custom_hook_HitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [self custom_hook_HitTest:point withEvent:event];
}

- (BOOL)custom_hook_PointInside:(CGPoint)point withEvent:(UIEvent *)event {
    UIViewController *first = [UIViewController currentViewController];
    BOOL hasMap = NO;
    IBHeatMap *heatMap;
    for (UIView *v in first.view.subviews) {
        if ([v isKindOfClass:[IBHeatMap class]]) {
            hasMap = YES;
            heatMap = (IBHeatMap *)v;
            break;
        }
    }
    
    if (!hasMap) {
        heatMap = [[IBHeatMap alloc] initWithFrame:first.view.frame points:@[] colors:@[[UIColor greenColor], [UIColor yellowColor], [UIColor redColor]] pointRadius:30];
        heatMap.delegate = self;
        [first.view addSubview:heatMap];
        [first.view bringSubviewToFront:heatMap];
    } else {

        CGPoint relativePoint = CGPointMake(point.x / first.view.frame.size.width, point.y / first.view.frame.size.height);
        NSMutableArray *points = [heatMap.points mutableCopy];
        [points addObject:[NSValue valueWithCGPoint:relativePoint]];
        heatMap.points = points;
    }
    
    return [self custom_hook_PointInside:point withEvent:event];
}

-(void)heatMapFinishedLoading {
    NSLog(@"FinishedLoadingHeatMap");
}

@end
