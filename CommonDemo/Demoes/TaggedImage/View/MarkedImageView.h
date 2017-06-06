//
//  MarkedImageView.h
//  TidusWWDemo
//
//  Created by Tidus on 17/1/18.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagViewModel.h"
#import "TagView.h"

typedef void(^markedImageDidTapBlock)(TagViewModel *);
typedef void(^deleteTagViewBlock)(TagViewModel *);

@interface MarkedImageView : UIImageView

//标签视图数组
@property (nonatomic, strong) NSMutableArray<TagView *> *tagViews;
//是否可以编辑（添加删除标签）
@property (nonatomic, assign) BOOL editable;
//是否已经显示标签
@property (nonatomic, assign, getter=isShowed) BOOL showed;
//模糊背景
@property (nonatomic, strong) UIImage *blurImage;
//点击图片block
@property (nonatomic, copy) markedImageDidTapBlock markedImageDidTapBlock;
//删除标签block
@property (nonatomic, copy) deleteTagViewBlock deleteTagViewBlock;




- (void)createTagView:(NSMutableArray<TagViewModel *> *)viewModels;
- (void)showTagViews;
- (void)hideTagViews;
@end
