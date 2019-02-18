//
//  FriendCircleViewController.m
//  HighCopyWeChat
//
//  Created by simple on 2018/10/14.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import "FriendCircleViewController.h"
#import "CircleHeadView.h"
#import "SectionHeadView.h"
#import "LikeCircleTableViewCell.h"
#import "CommentsTableViewCell.h"
#import "CircleModelViewModel.h"
#import "CircleModel.h"
#import "Masonry.h"



@interface FriendCircleViewController ()<UITableViewDataSource,UITableViewDelegate,SectionHeadViewDelegate,LikeCircleTableViewCellDelegate,CommentsTableViewCellDelegate,UITextViewDelegate>
{
    NSMutableArray *dataArray;
    UITableView *circleTab;
    CircleModel *item;
    SectionHeadView *secView;
    NSInteger commentsSection;
}
@property(nonatomic,strong)UIView *textBackView;
@property(nonatomic,strong)UITextView *commentsTextV;
@property(nonatomic,strong)UITableView *circleTable;
@property(nonatomic,strong)UIView *closeKeyboardYbgView;
@end

@implementation FriendCircleViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:17]}];
                                                                      
    self.view.backgroundColor = [UIColor whiteColor];
    CircleHeadView *headV = [[CircleHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 280)];
    self.circleTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-(kHeight_TabBar)) style:UITableViewStyleGrouped];
    dataArray = [NSMutableArray arrayWithArray:[[CircleModelViewModel alloc] lodaData]];
    
    self.circleTable.tableHeaderView = headV;
    self.circleTable.dataSource = self;
    self.circleTable.delegate =self;
    self.circleTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.closeKeyboardYbgView = [[UIView alloc]init];
    self.closeKeyboardYbgView.backgroundColor = [UIColor clearColor];
    self.closeKeyboardYbgView.userInteractionEnabled = YES;
    
    [self.view addSubview:_circleTable];
    [self.view addSubview:_closeKeyboardYbgView];
    [self setTextViewFrame];
    
}

#pragma tableview data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CircleModel *sectionItem = dataArray[indexPath.section];
    if (sectionItem.likerRowHeight > 14) {
        if (indexPath.row == 0) {
            CGFloat height = sectionItem.likerRowHeight + 10;
            return height;
        }else{
            CGFloat height1 = [sectionItem.commentHeightArr[indexPath.row - 1] floatValue] +10;
            return height1;
        }
    }else{
        CGFloat height2 = [sectionItem.commentHeightArr[indexPath.row] floatValue] + 10;
        return height2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CircleModel *sectionItem = dataArray[section];
    return sectionItem.headerHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 7.7, kScreenWidth, 0.3)];
    view2.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [view addSubview:view2];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *secViewID = @"sectionReusableId";
    secView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:secViewID ];
    secView = [[SectionHeadView alloc]initWithReuseIdentifier:secViewID];
    CircleModel *sectionItem = dataArray[section];
    secView.delegate = self;
    [secView setSectionMessage:sectionItem :section];
    return secView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CircleModel *sectionItem = dataArray[section];
    return sectionItem.cellCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID0 = @"likeCellId";
    static NSString *cellID1 = @"circleCellId";
    LikeCircleTableViewCell *likeCell = [tableView dequeueReusableCellWithIdentifier:cellID0];
    CommentsTableViewCell *commentsCell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    commentsCell.delegate = self;

    CircleModel *sectionItem = dataArray[indexPath.section];
    NSDictionary *commentsDic = [NSDictionary dictionary];

    if (sectionItem.like_users.count > 0) {
        if (indexPath.row == 0) {
            if (likeCell == nil) {
                likeCell = [[LikeCircleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID0];
            }
            likeCell.delegate = self;
            [likeCell getLikerString:sectionItem];
            return likeCell;
        }else{
            if (commentsCell == nil) {
                commentsCell = [[CommentsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
            }
            commentsDic = sectionItem.comments[indexPath.row - 1];
            [commentsCell getCommntsString:sectionItem :commentsDic];
            return commentsCell;
        }
    }else{
        if (commentsCell == nil) {
            commentsCell = [[CommentsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        }
        commentsDic = sectionItem.comments[indexPath.row];
        [commentsCell getCommntsString:sectionItem :commentsDic];
        return commentsCell;
    }
}
//判断全文按钮是否展开，更新高度
-(void)foldingContent:(BOOL)folding :(NSInteger)section{
    CircleModel *sectionItem = dataArray[section];
    sectionItem.folding = folding;
    sectionItem.headerHeight = [[CircleModelViewModel alloc] getHeaderHeight:sectionItem];
    [self.circleTable reloadData];

}
//点击cell中名字弹出新vc
- (void)didSelectPeople:(NSDictionary *)dic {
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.navigationItem.title = [dic valueForKey:@"user_name"];
    [self.navigationController pushViewController:vc animated:YES];
}
//点击点赞按钮
- (void)didClickLikeButton:(NSInteger)section {
    CircleModel *item = dataArray[section];
    NSMutableArray *likerArray = [NSMutableArray arrayWithArray:item.like_users];
    BOOL isContain = NO;
    NSDictionary *containDic = nil;
    for (NSDictionary *likerDic in item.like_users) {
        if ([likerDic[@"userName"] isEqualToString:@"Simple"]) {
            isContain = YES;
            containDic = likerDic;
            break;
        }
    }
    if (isContain) {
        secView.ContainLiker = YES;
        [likerArray removeObject:containDic];
    } else {
        secView.ContainLiker = NO;
        [likerArray addObject:@{@"userId": @"0", @"userName": @"Simple"}];
    }
    item.like_users = [likerArray copy];
    item.likerRowHeight = [[CircleModelViewModel new] getLikerCellRowHeight:item];
    item.cellCount = [[CircleModelViewModel new] getSectionAllCellCount:item];
    [self.circleTable reloadData];

}
//设置评论输入框View
-(void)setTextViewFrame{
    self.textBackView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 49)];
    self.textBackView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    self.commentsTextV = [[UITextView alloc]init];
    self.commentsTextV.clipsToBounds = YES;
    self.commentsTextV.layer.cornerRadius = 5;
    self.commentsTextV.delegate = self;
    self.commentsTextV.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_textBackView];
    [self.textBackView addSubview:_commentsTextV];

    [self.commentsTextV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(@7);
        make.right.equalTo(@-40);
        make.height.equalTo(@35);
    }];

}
//键盘弹出，更新frame
-(void)keyboardWillShow :(NSNotification *)notification{
    NSDictionary *user = notification.userInfo;
    double duration = [user[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat endKeyboardY = [user[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    [UIView animateWithDuration:duration animations:^{
        self.closeKeyboardYbgView.frame = CGRectMake(0, 0, kScreenWidth, endKeyboardY - (kHeight_TabBar));
        self.textBackView.frame = CGRectMake(0, endKeyboardY - (kHeight_TabBar), kScreenWidth, kHeight_TabBar);
        self.circleTable.frame = CGRectMake(0, 0, kScreenWidth, endKeyboardY - (kHeight_TabBar));
    }];
    
    
}
//点击评论按钮
- (void)didClickCommentButton:(NSInteger)section {
    self.closeKeyboardYbgView.hidden = NO;
    [self.commentsTextV becomeFirstResponder];
    CircleModel *item = dataArray[section];
    commentsSection = section;
    [UIView animateWithDuration:0.3 animations:^{
        [self.circleTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:item.cellCount -1 inSection:section] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }];
   
}
//键盘隐藏，恢复frame
-(void)keyboardWillhide :(NSNotification *)notification{
    self.closeKeyboardYbgView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.textBackView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kHeight_TabBar);
        self.circleTable.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight- (kHeight_TabBar));
    }];
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        if (textView.text.length == 0) {
            [self.commentsTextV resignFirstResponder];
            return NO;
        }{
            [self addCommnets:self.commentsTextV.text];
            self.commentsTextV.text = nil;
            [self.commentsTextV resignFirstResponder];
        }
    }
    return YES;
}
//添加评论
-(void)addCommnets:(NSString *)comments{
    CircleModel *item = dataArray[commentsSection];
    NSMutableArray *addCommnetsArray = [NSMutableArray arrayWithArray:item.comments];
    NSDictionary *commentsDic = @{@"comment_user_id": @"0",
                                  @"comment_user_name": @"Simple",
                                  @"comment_text":comments};
    [addCommnetsArray addObject:commentsDic];
    item.comments = [addCommnetsArray copy];
    item.commentHeightArr = [[CircleModelViewModel new] getCommentsCellRowHeight:item];
    item.cellCount = [[CircleModelViewModel new] getSectionAllCellCount:item];
    [self.circleTable reloadData];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.commentsTextV endEditing:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
