//
//  TranslateBubbleView.m
//
//  Created by 杜 on 2018/7/03.
//  Copyright © 2018年 杜. All rights reserved.
//

#import "TranslateBubbleView.h"
#import "TranslateModel.h"

@interface TranslateBubbleView ()
@property (nonatomic, strong) UILabel *originalLabel;
@property (nonatomic, strong) UILabel *translationLabel;
@property (nonatomic, strong) UIView *midLine;

@end

@implementation TranslateBubbleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    _originalLabel = [[UILabel alloc] init];
    _originalLabel.numberOfLines = 0;
    _originalLabel.font = [UIFont systemFontOfSize:15];
    _originalLabel.textColor = TEXTCOLOR_BLACK;
    [self addSubview:_originalLabel];
    
    _translationLabel = [[UILabel alloc] init];
    _translationLabel.numberOfLines = 0;
    _translationLabel.font = [UIFont systemFontOfSize:15];
    _translationLabel.textColor = TEXTCOLOR_BLACK;
    [self addSubview:_translationLabel];
    
    _midLine = [[UIView alloc] init];
    [self addSubview:_midLine];
}

- (void)setupBubbleData:(TranslateModel *)model
{
    UIImage *image = !model.isSend ? [[UIImage imageNamed:@"words_bubble_left_img"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] : [[UIImage imageNamed:@"words_bubble_right_img"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    UIImage *highImage = !model.isSend ? [[UIImage imageNamed:@"words_bubble_left_highlighted_img"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] : [[UIImage imageNamed:@"words_bubble_right_highlighted_img"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [self setBackgroundImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:highImage forState:UIControlStateHighlighted];
    
    _originalLabel.text = model.originalText;
    _translationLabel.text = model.translationText;
    
    _midLine.backgroundColor = !model.isSend ? UIColorFromRGB(0xE4E4E8) : UIColorFromRGBWithAlpha(0xFFFFFF, 0.3);
}

- (void)updateBubbleFrame:(TranslateModel *)model
{
    if (!model.isSend) {
        _originalLabel.frame = CGRectMake(PaddingSpacing, HorizontalSpacing, self.frame.size.width - (PaddingSpacing * 2), model.originalHeight);
        _translationLabel.frame = CGRectMake(_originalLabel.frame.origin.x, CGRectGetMaxY(_originalLabel.frame) + (HorizontalSpacing * 2), _originalLabel
                                             .frame.size.width, model.translationHeight);
    }
    else {
        _originalLabel.frame = CGRectMake(PaddingSpacing, HorizontalSpacing, self.frame.size.width - (PaddingSpacing * 2), model.originalHeight);
        _translationLabel.frame = CGRectMake(_originalLabel.frame.origin.x, CGRectGetMaxY(_originalLabel.frame) + (HorizontalSpacing * 2), _originalLabel
                                             .frame.size.width, model.translationHeight);
    }
    _midLine.frame = CGRectMake(_originalLabel.frame.origin.x, CGRectGetMaxY(_originalLabel.frame) + 9.5, _originalLabel.frame.size.width, 1);
}

@end
