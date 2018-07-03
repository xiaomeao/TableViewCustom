//
//  TranslateToolbarView.m
//
//  Created by 杜 on 2018/7/03.
//  Copyright © 2018年 杜. All rights reserved.
//

#import "TranslateToolbarView.h"
#import "UIView+Extension.h"
#import "CommonConfig.h"

@interface StyleBtn : UIButton
@end
@implementation StyleBtn
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.size = CGSizeMake(44, 44);
    
    self.imageView.size = CGSizeMake(24, 24);
    self.imageView.x = (self.width - 24) / 2.0;
    self.imageView.y = 3;
    
    self.titleLabel.size = CGSizeMake(44, 10);
    self.titleLabel.x = 0;
    self.titleLabel.y = 44 - 10 - 3;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:10];
}
@end


@interface TranslateToolbarView ()<UITextFieldDelegate>

@property(nonatomic, strong) UIView *toolbarView;//白色底view
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) StyleBtn *languageBtn;//语言类型按钮
@property (nonatomic, strong) UIView *bgTextView;//输入底框
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) NSInteger sum;//控制语言类型按钮切换 自动-0 中文-1 英语-2

@end

@implementation TranslateToolbarView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShowNotification:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShowNotification:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        [self createView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _toolbarView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _line.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
    _languageBtn.frame = CGRectMake(self.frame.size.width - 7 - 44, 3, 44, 44);
    _bgTextView.frame = CGRectMake(7, 7, self.frame.size.width - 44 - (7 * 3), 36);
    _textField.frame = CGRectMake(15, 0, _bgTextView.frame.size.width - 30, 36);
}

- (void)createView
{
    _sum = 1;
    
    _toolbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _toolbarView.backgroundColor = UIColorFromRGB(0xFCFCFC);
    [self addSubview:_toolbarView];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    _line.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [_toolbarView addSubview:_line];
    
    _languageBtn = [StyleBtn buttonWithType:UIButtonTypeCustom];
    _languageBtn.frame = CGRectMake(self.frame.size.width - 7 - 44, 3, 44, 44);
    [_languageBtn setTitleColor:TEXTCOLOR_BLACK forState:UIControlStateNormal];
    [_toolbarView addSubview:_languageBtn];
    [_languageBtn addTarget:self action:@selector(languageButtonAction:) forControlEvents:UIControlEventTouchDown];
    
    NSString *title = @"自动";
    UIImage *image = [UIImage imageNamed:@"translate_auto_img"];
    [_languageBtn setTitle:title forState:UIControlStateNormal];
    [_languageBtn setImage:image forState:UIControlStateNormal];
    
    _bgTextView = [[UIView alloc] initWithFrame:CGRectMake(7, 7, self.frame.size.width - 44 - (7 * 3), 36)];
    [_bgTextView roundedRectWithRadius:20];
    [_bgTextView borderColor:UIColorFromRGB(0xDDDDDD) borderWidth:0.5];
    [_toolbarView addSubview:_bgTextView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, _bgTextView.frame.size.width - 30, 36)];
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.textColor = TEXTCOLOR_BLACK;
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeySend;
    [_bgTextView addSubview:_textField];
}

#pragma mark - Action
- (void)languageButtonAction:(UIButton *)sender
{
    TranslateLanguageType type = sTranslateLanguageTypeAuto;
    if (_sum == 0) {
        [_languageBtn setTitle:@"自动" forState:UIControlStateNormal];
        [_languageBtn setImage:[UIImage imageNamed:@"translate_auto_img"] forState:UIControlStateNormal];
        type = sTranslateLanguageTypeAuto;
    }
    if (_sum == 1) {
        [_languageBtn setTitle:@"中文" forState:UIControlStateNormal];
        [_languageBtn setImage:[UIImage imageNamed:@"translate_chinesee_img"] forState:UIControlStateNormal];
        type = sTranslateLanguageTypeChinese;
    }
    if (_sum == 2) {
        [_languageBtn setTitle:@"英文" forState:UIControlStateNormal];
        [_languageBtn setImage:[UIImage imageNamed:@"translate_english_img"] forState:UIControlStateNormal];
        type = sTranslateLanguageTypeEnglish;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(languageChangeType:)]) {
        [_delegate languageChangeType:type];
    }
    _sum++;
    if (_sum > 2) {
        _sum = 0;
    }
}

#pragma mark - textField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [[UIMenuController sharedMenuController] setMenuItems:nil];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField.text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (textField.text.length > 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(didReturnText:)]) {
            [_delegate didReturnText:textField.text];
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(range.location >= 150) {
        return NO;
    }
    return YES;
}

- (void)clearText
{
    _textField.text = @"";
}

#pragma mark -
#pragma mark - 自定义键盘打开时触发的事件
-(void)keyboardWillShowNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    BOOL isShowNotification = [notification.name isEqualToString:UIKeyboardWillShowNotification];
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat keyboardHeight = isShowNotification ? CGRectGetHeight(keyboardFrame) : 0.0;
    
    WEAKSELF
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect rectFrame = weakSelf.frame;
        rectFrame.origin.y = weakSelf.superview.frame.size.height - keyboardHeight - (isShowNotification ? 49 : Tabbar_Height);
        rectFrame.size.height = isShowNotification ? 49 : Tabbar_Height;
        weakSelf.frame = rectFrame;
    }];
    if (!isShowNotification) {
        [_textField resignFirstResponder];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(toolbarDidChangeFrameToHeight:isAppear:)]) {
        [_delegate toolbarDidChangeFrameToHeight:keyboardHeight isAppear:isShowNotification];
    }
}


@end
