//
//  TranslateModel.m
//
//  Created by 杜 on 2018/7/03.
//  Copyright © 2018年 杜. All rights reserved.
//

#import "TranslateModel.h"

@implementation TranslateModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isSend = NO;
        _originalText = @"";
        _translationText = @"";
        _cellHeight = 0;
        _bubbleWidth = 0;
        _originalHeight = 0;
        _translationHeight = 0;
    }
    return self;
}

@end
