//
//  XYJUIViewControllerDismissAnimatedTransitioning.m
//  XYJCollectionUIViewControllerAnimatedTransitioning
//
//  Created by 肖迎军 on 2021/2/20.
//

#import "XYJUIViewControllerDismissAnimatedTransitioning.h"

@implementation XYJUIViewControllerDismissAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    // 获取转场信息
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    CGRect containerBounds = [transitionContext containerView].bounds;
    
    // 计算转场前后状态
    CGRect fromViewBeginFrame = containerBounds;
    CGRect fromViewEndFrame = CGRectMake(0, containerBounds.size.height, containerBounds.size.width, containerBounds.size.height);

    // 动画初始状态
    [transitionContext.containerView insertSubview:toView belowSubview:fromView];
    toView.frame = containerBounds;
    fromView.frame = fromViewBeginFrame;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] * 0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
        // 动画结束状态
        fromView.frame = fromViewEndFrame;
        
    } completion:^(BOOL finished) {
        // 动画完成
        [transitionContext completeTransition:finished];
    }];
    
}

@end
