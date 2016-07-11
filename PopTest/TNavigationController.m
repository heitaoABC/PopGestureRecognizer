//
//  TNavigationController.m
//  PopTest
//
//  Created by 1217 on 16/7/11.
//  Copyright © 2016年 路一枭. All rights reserved.
//

#import "TNavigationController.h"


@interface TNavigationController () <UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIPanGestureRecognizer *customGesture;
@end

@implementation TNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    [super pushViewController:viewController animated:animated];
    
    if ([self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.customGesture]) return;
    
    /* UIGestureRecognizerTarget */
    id targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"][0];
    
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    id target = [targets valueForKey:@"target"];
    
    [self.customGesture addTarget:target action:action];
    [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.customGesture];
}

- (UIPanGestureRecognizer *)customGesture
{
    if (!_customGesture) {
        _customGesture = [[UIPanGestureRecognizer alloc] init];
        _customGesture.delegate = self;
    } return _customGesture;
}

#pragma mark ***** delegate **

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count <= 1) return NO;
    
    return YES;
}

@end
