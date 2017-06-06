//
//  TagView.h
//  TidusWWDemo
//
//  Created by Tidus on 17/1/18.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagViewModel.h"


@class TagView;
typedef void(^centerDidTapBlock)(TagView *);
typedef void(^textDidTapBlock)(TagView *);
typedef void(^longPressBlock)(TagView *);

@interface TagView : UIView

//viewModel
@property (nonatomic, strong) TagViewModel *viewModel;

//手势事件
@property (nonatomic, copy) centerDidTapBlock centerDidTapBlock;
@property (nonatomic, copy) textDidTapBlock textDidTapBlock;
@property (nonatomic, copy) longPressBlock longPressBlock;


@property (nonatomic, assign) BOOL viewHidden;


//判断point是否在frame中
- (BOOL)pointInside:(CGPoint)point;
//利用viewModel初始化
- (instancetype)initWithTagModel:(TagViewModel *)viewModel;
//是否需要更新原点坐标
- (void)setNeedsUpdateCenter;
//显示动画
- (void)showWithAnimate:(BOOL)animate;
//隐藏动画
- (void)hideWithAnimate:(BOOL)animate;
@end
