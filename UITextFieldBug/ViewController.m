//
//  ViewController.m
//  UITextFieldBug
//
//  Created by klwx on 16/6/16.
//  Copyright © 2016年 wufan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (nonatomic ,weak) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"ico_mimabukejian"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"ico_mimakejian"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(textFieldRightBtnTouchDown:) forControlEvents:UIControlEventTouchDown];
    [rightBtn addTarget:self action:@selector(textFieldRightBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 44)];
    textField.font = [UIFont systemFontOfSize:16];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"在此输入文字";
    textField.secureTextEntry = YES;
    textField.rightView = rightBtn;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.delegate = self;
    [self.view addSubview:textField];
    self.textField = textField;
}

- (void)textFieldRightBtnTouchDown:(UIButton *)rightBtn {
    self.textField.secureTextEntry = NO;
    //法一
    [self.textField becomeFirstResponder];
    //法二
//    NSString *textStr = self.textField.text;
//    self.textField.text = @"";
//    self.textField.text = textStr;
    
    self.textField.font = nil;
    self.textField.font = [UIFont systemFontOfSize:16];
}

- (void)textFieldRightBtnTouchUpInside:(UITextField *)textField {
    self.textField.secureTextEntry = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *allStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField.isSecureTextEntry == YES) {
        textField.text = allStr;
        return NO;
    }
    
    return YES;
}

@end
