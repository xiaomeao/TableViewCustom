//
//  ViewController.m
//  TableViewDemo
//
//  Created by 杜 on 2018/7/3.
//  Copyright © 2018年 杜. All rights reserved.
//

#import "ViewController.h"
#import "CommonConfig.h"
#import "TranslateCell.h"
#import "TranslateModel.h"
#import "TranslateToolbarView.h"
#import "TranslateModelDataManager.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, TranslateCellDelegate, TranslateToolbarViewDelegate>
{
    UIMenuItem *_copyMenuItem;//复制
    UIMenuItem *_shareMenuItem;//分享
    UIMenuItem *_deleteMenuItem;//删除
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TranslateToolbarView *toolbarView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSIndexPath *menuIndexPath;//长按时选中消息菜单索引


@end

@implementation ViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.title = @"文字";
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc] init];
    _menuIndexPath = nil;
    
    [self setupTalbeView];
    [self setupToolBar];
    [self autoSetupDatas];
}

- (void)setupTalbeView
{
    CGFloat navH = IPHONE_X ? 44 : 20;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navH, IPHONE_WIDTH, self.view.frame.size.height - Tabbar_Height - navH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)setupToolBar
{
    _toolbarView = [[TranslateToolbarView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - Tabbar_Height, IPHONE_WIDTH, self.view.frame.size.height)];
    _toolbarView.delegate = self;
    [self.view addSubview:_toolbarView];
    [self.view bringSubviewToFront:_toolbarView];
}

#pragma mark - tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TranslateModel *model = (TranslateModel *)_dataArray[indexPath.row];
    static NSString *cellIdentifier = @"TranslateCell";
    TranslateCell *cell = (TranslateCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[TranslateCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:cellIdentifier
                                              model:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    model.indexPath = indexPath;
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[UIMenuController sharedMenuController] setMenuVisible:NO];
    [self scrollViewWillBeginDragging:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count > 0) {
        TranslateModel *model = (TranslateModel *)_dataArray[indexPath.row];
        return model.cellHeight;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArray.count > 0) {
        return _dataArray.count;
    }
    return 0;
}

- (void)scrollViewToBottom:(BOOL)animated
{
    if (_dataArray.count > 0) {
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
    //    if (self.tableView.contentSize.height > self.tableView.frame.size.height) {
    //        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
    //        [self.tableView setContentOffset:offset animated:animated];
    //    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.tableView == scrollView) {
        [[UIMenuController sharedMenuController] setMenuVisible:NO];
        [self.view endEditing:YES];
        [self.toolbarView endEditing:YES];
    }
}

#pragma mark - translateCell delegate
#pragma mark 长按
- (void)longpressAction:(TranslateCell *)cell model:(TranslateModel *)model
{
    [self moreMenu];
    NSIndexPath *indexPath = (NSIndexPath *)[_tableView indexPathForCell:cell];
    _menuIndexPath = indexPath;
    
    [[UIMenuController sharedMenuController] setMenuItems:@[_copyMenuItem, _shareMenuItem, _deleteMenuItem]];
    [[UIMenuController sharedMenuController] setTargetRect:cell.bubbleView.frame inView:cell.bubbleView.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

#pragma mark - toolbar delegate
#pragma mark 改变界面变化
- (void)toolbarDidChangeFrameToHeight:(CGFloat)toHeight isAppear:(BOOL)appear
{
    CGFloat navH = IPHONE_X ? 44 : 20;
    CGFloat toolbarHeight = appear ? 49 : Tabbar_Height;
    CGRect rect = _tableView.frame;
    rect.size.height = self.view.frame.size.height - navH - toHeight - toolbarHeight;
    _tableView.frame = rect;
    [self scrollViewToBottom:YES];
}

#pragma mark 输入文字
- (void)didReturnText:(NSString *)text
{
    TranslateModel *model = [TranslateModelDataManager obtainUserMessWithOriginalText:text translationText:@""];
    [_dataArray addObject:model];
    [_tableView reloadData];
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf scrollViewToBottom:YES];
    });
    [self.view endEditing:YES];
    [self.toolbarView endEditing:YES];
    [self.toolbarView clearText];
}

#pragma mark 识别语音设置
- (void)languageChangeType:(TranslateLanguageType)type
{
    TranslateModel *model = nil;
    switch (type) {
        case sTranslateLanguageTypeAuto:
            model = [TranslateModelDataManager obtainTipMessWith:sTranslateCharacterTypeAuto];
            break;
        case sTranslateLanguageTypeChinese:
            model = [TranslateModelDataManager obtainTipMessWith:sTranslateCharacterTypeChinese];
            break;
        case sTranslateLanguageTypeEnglish:
            model = [TranslateModelDataManager obtainUserMessWithOriginalText:@"" translationText:@""];
            break;
        default:
            break;
    }
    if (model) {
        [_dataArray addObject:model];
        [self refreshTableView];
    }
}

#pragma mark - Method
#pragma mark 刷新界面
- (void)refreshTableView
{
    [_tableView reloadData];
    if (_dataArray.count >= 2) {
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count - 2 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    WEAKSELF
    if (self.tableView.contentSize.height > self.tableView.frame.size.height) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf scrollViewToBottom:YES];
        });
    }
}

#pragma mark 进入界面默认推一条消息
- (void)autoSetupDatas
{
    TranslateModel *model = [TranslateModelDataManager obtainTipMessWith:sTranslateCharacterTypeNormal];
    [_dataArray addObject:model];
    [_tableView reloadData];
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf scrollViewToBottom:YES];
    });
}

#pragma mark - Action
- (void)xcopyMenuAction:(id)sender
{
    //TODO:复制译文
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (_menuIndexPath) {
        TranslateModel *model = [_dataArray objectAtIndex:_menuIndexPath.row];
        pasteboard.string = model.translationText;
        NSLog(@"复制 -- %s",__func__);
    }
    _menuIndexPath = nil;
}

- (void)shareMenuAction:(id)sender
{
    //TODO:分享
    if (_menuIndexPath) {
        NSLog(@"分享 -- %s",__func__);
    }
    _menuIndexPath = nil;
}

- (void)removeMenuAction:(id)sender
{
    //TODO:删除
    if (_menuIndexPath) {
        [_dataArray removeObjectAtIndex:_menuIndexPath.row];
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:@[_menuIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];
        NSLog(@"删除 -- %s",__func__);
    }
    _menuIndexPath = nil;
}

- (void)moreMenu
{
    if (_copyMenuItem == nil) {
        _copyMenuItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(xcopyMenuAction:)];
    }
    if (_shareMenuItem == nil) {
        _shareMenuItem = [[UIMenuItem alloc] initWithTitle:@"分享" action:@selector(shareMenuAction:)];
    }
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(removeMenuAction:)];
    }
}

@end
