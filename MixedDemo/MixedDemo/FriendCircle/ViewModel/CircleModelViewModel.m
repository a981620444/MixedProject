//
//  CircleModelViewModel.m
//  HighCopyWeChat
//
//  Created by simple on 2018/10/14.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import "CircleModelViewModel.h"
#import "CircleModel.h"
#import <UIKit/UIKit.h>

@implementation CircleModelViewModel

-(NSMutableArray *)lodaData{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]]];
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *allItemArray = [NSMutableArray array];
    for (NSDictionary *rowDic in dataDic[@"data"][@"rows"]) {
        CircleModel *item = [[CircleModel alloc]initWithItem:rowDic];
        item.contentLabelHeight = [self CalculateContentHeight:item.message];
        item.imageViewHeight = [self getPictureImageViewHeight:item.small_pics];
        item.headerHeight = [self getHeaderHeight:item];
        item.likerRowHeight = [self getLikerCellRowHeight:item];
        item.commentHeightArr = [self getCommentsCellRowHeight:item];
        item.cellCount = [self getSectionAllCellCount:item];
        
        [allItemArray addObject:item];
    }
    return allItemArray;
}

-(CGFloat)CalculateContentHeight:(NSString *)string{
    
    if (string ==nil | string.length <= 0) {
        return 0;
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, string.length)];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];

    CGSize attSize = [str boundingRectWithSize:CGSizeMake(kScreenWidth - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    return ceil(attSize.height);

}
-(CGFloat)getPictureImageViewHeight:(NSArray *)picture{
    if (picture.count == 0) {
        return 0;
    }else if (picture.count == 1){
        return 100;
    }else if (picture.count <= 3){
        return 70;
    }else if (picture.count <= 6){
        return 140 + 5;
    }else {
        return 210 + 10;
    }
}
-(CGFloat)getHeaderHeight:(CircleModel *)item{

    if (item.folding) {
        if (item.imageViewHeight > 0) {
            item.headerHeight = item.contentLabelHeight+item.imageViewHeight+8+8+8+8+8+65+8;
        }else{
            item.headerHeight = item.contentLabelHeight+8+8+8+8+65+8;
        }
    }else{
        if (item.contentLabelHeight <= 0) {
            item.headerHeight = item.imageViewHeight + 32 + 40;
        }else if (item.contentLabelHeight <= 104){
            if (item.imageViewHeight > 0) {
                item.headerHeight = item.contentLabelHeight + item.imageViewHeight + 40 + 40;
            }else{
                item.headerHeight = item.contentLabelHeight + 32 + 40;
            }
        }else{
            if (item.imageViewHeight > 0) {
                item.headerHeight = 104 + item.imageViewHeight + 48 + 65;
            }else{
                item.headerHeight = 104 + 40 + 65;
            }
        }
    }
    return item.headerHeight;
}
-(CGFloat)getLikerCellRowHeight:(CircleModel *)item{
    NSString *space = @"       ";
    NSString *symbol = @", ";
    NSMutableString *liker = [NSMutableString string];
    for (NSDictionary *dic in item.like_users) {
        NSString *singleLiker = dic[@"userName"];
        NSString *addSymbol = [NSString string];
        if ([singleLiker isEqualToString:item.like_users[0][@"userName"]]) {
            
            addSymbol = [space stringByAppendingString:singleLiker];
        }else{
            
            addSymbol = [symbol stringByAppendingString:singleLiker];
        }
        [liker appendString:addSymbol];
    }
    
    NSString *likerString = [NSString stringWithString:liker];
    
    NSMutableAttributedString *attributeLiker = [[NSMutableAttributedString alloc]initWithString:likerString];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 2;
    [attributeLiker addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, likerString.length)];
    [attributeLiker addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, likerString.length)];
    
    CGFloat heighht = [attributeLiker boundingRectWithSize:CGSizeMake(kScreenWidth - 70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
    
    NSInteger likerHeight = ceil(heighht);
    return likerHeight;
}

-(NSMutableArray *)getCommentsCellRowHeight:(CircleModel *)item{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *commentsDic in item.comments) {
        NSString *commentsText = [NSString string];
        if (commentsDic[@"comment_to_user_name"] == nil || [commentsDic[@"comment_to_user_name"] isEqualToString:item.user_name]) {
            commentsText = [NSString stringWithFormat:@"%@: %@",commentsDic[@"comment_user_name"],commentsDic[@"comment_text"]];
        }else{
            commentsText = [NSString stringWithFormat:@"%@回复%@: %@",commentsDic[@"comment_user_name"],commentsDic[@"comment_to_user_name"], commentsDic[@"comment_text"]];
        }
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:commentsText];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
        paragraph.lineSpacing = 2;
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, commentsText.length)];
        [attString addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, commentsText.length)];
        
        CGFloat commentsHeight = [attString boundingRectWithSize:CGSizeMake(kScreenWidth - 70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
        NSNumber *height = [NSNumber numberWithFloat:ceil(commentsHeight)];
        
        [array addObject:height];
    }
    
    return array;
}

-(NSInteger)getSectionAllCellCount:(CircleModel *)item{
    NSInteger cellCount = 0;
    if (item.like_users.count > 0) {
        cellCount = item.comments.count + 1;
    }else{
        cellCount = item.comments.count;
    }
    return cellCount;
}

@end
