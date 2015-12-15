//
//  TestView.m
//  DZMEditShowKeyBoardTopDemo
//
//  Created by haspay on 15/11/18.
//  Copyright © 2015年 DZM. All rights reserved.
//

#import "TestView.h"
#import "DZMEditShowKeyBoardTop.h"
@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITextField *textField = [[UITextField alloc] init];
        textField.backgroundColor = [UIColor greenColor];
        textField.placeholder = @"你可以随便放多少层子控件里面";
        textField.delegate = self;
        [self addSubview:textField];
        self.textField = textField;
    }
    return self;
}


// 只要是在键盘没出来之前的先调用的编辑框代理都行
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [DZMEditShowKeyBoardTop maxYWithView:textField];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textField.frame = CGRectMake(50, 5, self.frame.size.width - 50, self.frame.size.height - 10);
    
}
@end
