//
//  DZMEditShowKeyBoardTop.m
//  DZMEditShowKeyBoardTopDemo
//
//  Created by DZM on 15/11/18.
//  Copyright © 2015年 DZM. All rights reserved.
//

#import "DZMEditShowKeyBoardTop.h"
@interface DZMEditShowKeyBoardTop()
@property (nonatomic,assign) CGSize currentSize;                      // 记录滚动控件原来的contensize
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) BOOL isThree;                             // 是否是第三方键盘
@property (nonatomic,assign) int three;                                // 第三方键盘需要调用willShow3次
@end
@implementation DZMEditShowKeyBoardTop
/**
 *  获取对象（单利）
 *
 *  @return DZMEditShowKeyBoardTop
 */
+ (DZMEditShowKeyBoardTop *)editShowKeyBoardTop
{
    static DZMEditShowKeyBoardTop *editShowKeyBoardTop = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        editShowKeyBoardTop = [[DZMEditShowKeyBoardTop alloc] init];
    });
    
    return editShowKeyBoardTop;
}

/**
 *  为一个对象添加键盘监听通知
 *
 *  @param object 对象（建议是UIViewController，其他不保证出错误）
 */
+ (void)addKeyBoardNotificationWithObject:(id)object
{
    // 警告不用管 你传进来的对象实现需要的方法就行了
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    // 监听键盘开始显示
    if ([object respondsToSelector:@selector(keyboardWillShowNotification:)]) {
        
        [notificationCenter addObserver:object selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    }
    
    if ([object respondsToSelector:@selector(keyboardDidShowNotification:)]) {
        
        // 监听键盘结束显示
        [notificationCenter addObserver:object selector:@selector(keyboardDidShowNotification:) name:UIKeyboardDidShowNotification object:nil];
    }
    
    if ([object respondsToSelector:@selector(keyboardWillHideNotification:)]) {
        
        // 监听键盘开始隐藏
        [[NSNotificationCenter defaultCenter] addObserver:object selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    if ([object respondsToSelector:@selector(keyboardDidHideNotification:)]) {
        
        // 监听键盘结束隐藏
        [notificationCenter addObserver:object selector:@selector(keyboardDidHideNotification:) name:UIKeyboardDidHideNotification object:nil];
    }
    
    if ([object respondsToSelector:@selector(keyboardWillChangeFrameNotification:)]) {
        
        // 监听键盘改变frame
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            [[NSNotificationCenter defaultCenter] addObserver:object selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
        }
    }
}



/**
 *  传入一个输入框获取输入框的最大Y值
 *
 *  @param view 编辑的输入框
 *
 *  @return 当前控件在当前界面的最大Y值
 */
+ (CGFloat)maxYWithView:(UIView *)view
{
    DZMEditShowKeyBoardTop *object = [DZMEditShowKeyBoardTop editShowKeyBoardTop];
    
    object.maxY = [DZMEditShowKeyBoardTop getMaxYWithView:view];
    
    return object.maxY;
}

/**
 *  获取位置得出最大Y值
 *
 *  @param view view
 *
 *  @return 最大Y值
 */
+ (CGFloat)getMaxYWithView:(UIView *)view
{
    // 获取当前输入框在当前屏幕上得位置
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [view convertRect:view.bounds toView:window];
    CGFloat maxY = CGRectGetMaxY(rect);
    return maxY;
}

/**
 *  键盘显示完毕 后 输入框弹到键盘上边 （显示）则在键盘监听方法keyboardDidShowNotification里面调用即可
 *
 *  @param notification 键盘通知的notification
 *  @param scrollView   一个能滚动的view
 *  @param maxY         输入控件的最大Y值 （如果不传值 会去单利对象里那通过maxYWithView初始化过得最大Y值）
 *  但是由于考虑这个MaxY说不定有些需要键盘与输入框中间有一点间距 可以通过单利取出 maxY + 间距值 就可以了
 */
+ (void)keyboardShowNotification:(NSNotification *)notification scrollView:(UIScrollView *)scrollView maxY:(CGFloat)maxY
{
    DZMEditShowKeyBoardTop *object = [DZMEditShowKeyBoardTop editShowKeyBoardTop];
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    float keyboardAnimationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 检测第三方键盘
    if ((int)keyboardFrame.size.height <= 0) {
        object.three = 0;
        object.isThree = YES;
    }
    
    if (object.isThree) {
        object.three += 1;
        if (object.three != 3) {
            return;
        }else{
            object.isThree = NO;
        }
        
        keyboardAnimationDuration = 0.25;
    }
    
    CGFloat keyboardY = keyboardFrame.origin.y;
    
    if (maxY > keyboardY) {
        
        if (scrollView != object.scrollView) {
            
            object.scrollView.contentSize = object.currentSize;
            
            int height = scrollView.contentSize.height;
            
            if (!height) {
                
                object.currentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height);
                
            }else{
                
                object.currentSize = scrollView.contentSize;
            }
            
            object.scrollView = scrollView;
            
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, object.currentSize.height + keyboardFrame.size.height - ([UIScreen mainScreen].bounds.size.height - [DZMEditShowKeyBoardTop getMaxYWithView:scrollView]));
            
        }
        
        [UIView animateWithDuration:keyboardAnimationDuration animations:^{
            
            scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y + (maxY - keyboardY));
        }];
    }
}

/**
 *  键盘开始隐藏 的时候 跟着退下去 （隐藏）则在键盘监听方法keyboardWillHideNotification里面调用即可
 *
 *  @param notification 键盘通知的notification
 */
+ (void)keyboardHideNotification:(NSNotification *)notification
{
    DZMEditShowKeyBoardTop *object = [DZMEditShowKeyBoardTop editShowKeyBoardTop];
    
    float keyboardAnimationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:keyboardAnimationDuration animations:^{
        
        object.scrollView.contentSize = object.currentSize;
        
    } completion:^(BOOL finished) {
        
        object.scrollView = nil;
        
        object.currentSize = CGSizeMake(0, 0);
    }];
    
}
@end
