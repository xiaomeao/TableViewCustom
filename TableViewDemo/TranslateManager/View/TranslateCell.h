//
//  TranslateCell.h
//
//  Created by 杜 on 2018/7/03.
//  Copyright © 2018年 杜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TranslateBubbleView.h"
#import "TranslateModel.h"

@protocol TranslateCellDelegate;
@interface TranslateCell : UITableViewCell

@property (weak, nonatomic) id<TranslateCellDelegate> delegate;

@property (nonatomic, strong) TranslateModel *model;

@property (nonatomic, strong) TranslateBubbleView *bubbleView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(TranslateModel *)model;

@end

@protocol TranslateCellDelegate <NSObject>

@required
- (void)longpressAction:(TranslateCell *)cell model:(TranslateModel *)model;

@end
