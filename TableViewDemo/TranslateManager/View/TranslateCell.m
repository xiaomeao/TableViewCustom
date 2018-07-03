//
//  TranslateCell.m
//
//  Created by 杜 on 2018/7/03.
//  Copyright © 2018年 杜. All rights reserved.
//

#import "TranslateCell.h"
#import "UIView+Extension.h"
#import "CommonConfig.h"

@interface TranslateCell ()

@end

@implementation TranslateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(TranslateModel *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _model = model;
        [self setupView];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)setupView
{
    for (UIView *vivi in self.contentView.subviews) {
        [vivi removeFromSuperview];
    }
    _bubbleView = [[TranslateBubbleView alloc] init];
    [self.contentView addSubview:_bubbleView];
    [_bubbleView addTapGestureWithBlock:^(UIView *view) {
        [[UIMenuController sharedMenuController] setMenuVisible:NO];
    }];
    [_bubbleView addGestureRecognizer:[self longpress]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self calculateBubbleFrame:_model];
    [_bubbleView updateBubbleFrame:_model];
}

- (void)setModel:(TranslateModel *)model
{
    _model = model;
    [_bubbleView setupBubbleData:model];
}

- (void)calculateBubbleFrame:(TranslateModel *)model
{
    CGFloat xFrame = !model.isSend ? PaddingSpacing : IPHONE_WIDTH - model.bubbleWidth - PaddingSpacing;
    CGFloat bubbleHeight = model.originalHeight + model.translationHeight + (HorizontalSpacing * 4);
    _bubbleView.frame = CGRectMake(xFrame, HorizontalSpacing, model.bubbleWidth, bubbleHeight);
}

#pragma mark -
- (UILongPressGestureRecognizer *)longpress
{
    UILongPressGestureRecognizer *_longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    _longGesture.minimumPressDuration = 1;
    return _longGesture;
}

#pragma mark - 长按消息
- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        if ([_delegate respondsToSelector:@selector(longpressAction:model:)]) {
            [_delegate longpressAction:self model:_model];
        }
    }
}

@end
