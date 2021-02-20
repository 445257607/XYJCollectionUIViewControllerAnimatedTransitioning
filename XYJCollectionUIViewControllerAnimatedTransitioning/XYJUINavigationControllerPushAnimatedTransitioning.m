//
//  XYJUINavigationControllerPushAnimatedTransitioning.m
//  XYJCollectionUIViewControllerAnimatedTransitioning
//
//  Created by 肖迎军 on 2021/2/20.
//

#import "XYJUINavigationControllerPushAnimatedTransitioning.h"

@interface XYJUINavigationControllerPushAnimatedTransitioning()

// 视差调光效果
@property UIView * parallaxDimmingView;

@end


@implementation XYJUINavigationControllerPushAnimatedTransitioning

- (instancetype)init
{
    self = [super init];
    if (self) {
        _parallaxDimmingView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _parallaxDimmingView.backgroundColor = [UIColor blackColor];
        _parallaxDimmingView.alpha = 0.1;
    }
    return self;
}

- (void)dealloc
{
    if (_parallaxDimmingView.superview != nil) {
        [_parallaxDimmingView removeFromSuperview];
    }
}


#pragma mark - UIViewControllerAnimatedTransitioning


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
    CGRect fromViewEndFrame = CGRectMake(-containerBounds.size.width * 0.3, 0, containerBounds.size.width, containerBounds.size.height);
    CGRect toViewBeginFrame = CGRectMake(-containerBounds.size.width, 0, containerBounds.size.width, containerBounds.size.height);
    CGRect toViewEndFrame = containerBounds;
    
    // 动画初始状态
    [transitionContext.containerView insertSubview:toView aboveSubview:fromView];
    toView.frame = toViewBeginFrame;
    fromView.frame = fromViewBeginFrame;
    [transitionContext.containerView insertSubview:_parallaxDimmingView belowSubview:toView];
    _parallaxDimmingView.frame = containerBounds;
    _parallaxDimmingView.alpha = 0;
    
    __weak typeof (self) wself = self;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] * 0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
        // 动画结束状态
        toView.frame = toViewEndFrame;
        fromView.frame = fromViewEndFrame;
        wself.parallaxDimmingView.alpha = 0.1;
        
    } completion:^(BOOL finished) {
        // 动画完成
        [wself.parallaxDimmingView removeFromSuperview];
        [transitionContext completeTransition:finished];
    }];
    
}


@end
